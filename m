From: Richard Rossel <rrossel@inf.utfsm.cl>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 13:37:33 -0300
Message-ID: <4B2669CD.9020505@inf.utfsm.cl>
References: <4B264F7B.8070504@inf.utfsm.cl> <200912141655.01268.johan@herland.net> 	<8c9a060912140804t409030b4g168014bd80a0b88c@mail.gmail.com> 	<4B26669A.8020806@inf.utfsm.cl> <8c9a060912140828p3b05972lf9abc82c7b0f9bc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 17:38:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDve-0006Op-Vs
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbZLNQhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbZLNQhk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:37:40 -0500
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:50552 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbZLNQhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 11:37:40 -0500
Received: from trompe.intra.wiseocean.cl (red-corfo.tecnoera.net [200.24.238.226] (may be forged))
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id nBEGbX9R008560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 13:37:33 -0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <8c9a060912140828p3b05972lf9abc82c7b0f9bc1@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/10165/Mon Dec 14 12:47:56 2009 on alegre.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RDNS_NONE
	autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alegre.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135226>

>
> On Mon, Dec 14, 2009 at 08:23, Richard Rossel<rrossel@inf.utfsm.cl>  wrote:
>    
>> $ git --version
>> git version 1.5.4.3
>>
>> And when there is no change in the repo
>>
>> $ git fetch --q; echo $?
>> 0
>>
>> no messages and no error , but when there is a change to syncronize
>>
>> $ git fetch --q; echo $?
>> remote: Counting objects: 7, done.
>> remote: Compressing objects: 100% (5/5), done.
>> remote: Total 5 (delta remote: 2), reused 0 (delta 0)
>> Unpacking objects: 100% (5/5), done.
>>  From git@boss:sandbox
>>    3e4df7f..b92d27c  master     ->  origin/master
>> 0
>>
>>      
> Don't use a double dash, if you're using the short option.
>
> git fetch -q
> OR
> git fetch --quiet
>
> git fetch --q<--- This is not what you think it is.
>
> -Jacob
>
>    
doh, sorry, my mistake

$ git fetch -q; echo $?
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
 From git@boss:sandbox
    b92d27c..17b8b5d  master     -> origin/master
0

These is the output when there is a change to be syncronized

BTW,  in crontab the commands are using -q option, the mistake was made 
just here :)


-- 
Richard Rossel
Softare Engineer at Airsage Inc.
Valparaiso - Chile
