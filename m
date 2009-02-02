From: Sharib Khan <sak2109@columbia.edu>
Subject: Re: duplicate sign-off-by error
Date: Mon, 2 Feb 2009 15:16:30 -0500
Message-ID: <597340B9-A11E-4C69-8389-326D3777D9BA@columbia.edu>
References: <79FCCC4F-9C66-470E-AC32-8F3AE3C81EE9@columbia.edu> <200902021405.00562.bss@iguanasuicide.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:18:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5F2-0007j7-S4
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbZBBUQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbZBBUQe
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:16:34 -0500
Received: from brinza.cc.columbia.edu ([128.59.29.8]:33984 "EHLO
	brinza.cc.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbZBBUQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 15:16:34 -0500
Received: from [172.16.17.173] (vpn-wireless-client-pool-245-96.cpmc.columbia.edu [156.111.245.96])
	(user=sak2109 mech=PLAIN bits=0)
	by brinza.cc.columbia.edu (8.14.1/8.14.1) with ESMTP id n12KGUuR029186
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Feb 2009 15:16:31 -0500 (EST)
In-Reply-To: <200902021405.00562.bss@iguanasuicide.net>
X-Mailer: Apple Mail (2.930.3)
X-No-Spam-Score: Local
X-Scanned-By: MIMEDefang 2.65 on 128.59.29.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108116>


On Feb 2, 2009, at 3:04 PM, Boyd Stephen Smith Jr. wrote:

> On Monday 02 February 2009 11:22:36 Sharib Khan wrote:
>> I m getting a Duplicate Sign-off by error when trying to commit to
> the
>> repository.
>> I am using git 1.5.6 on solaris
>>
>> what is this error related to and how can it be resolved.
>
> It's looking for lines in the commit message like:
> Signed-off-by: Joe Hacker <jhacker@uni.edu>
>
but where are the commit messages stored - which file where i can find  
this
is it the COMMIT_EDITMSG file ?


> and seeing duplication.  Remove the duplication and try again.
>
> If you can't see the duplication, please try to put together a series
> operations we can preform to reproduce your error.

series of operations is

1. change to the file
2. save the file
3. git commit -a -m "change message"

at which pt, i get the duplication error

is this something related to solaris or git crashing - the commit had  
worked earlier ?

thanks

sk


>
> -- 
> Boyd Stephen Smith Jr.                     ,= ,-_-. =.
> bss@iguanasuicide.net                     ((_/)o o(\_))
> ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'
> http://iguanasuicide.net/                      \_/
>
