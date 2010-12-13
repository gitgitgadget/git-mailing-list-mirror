From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Splitting a repository but sharing the common parts of the object
 database
Date: Mon, 13 Dec 2010 18:17:31 -0500
Message-ID: <4D06A98B.1060408@cfl.rr.com>
References: <4D066873.4020208@cfl.rr.com> <20101213192053.GA30315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 00:18:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSHfE-0008ED-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 00:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab0LMXSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 18:18:35 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54910 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0LMXSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 18:18:34 -0500
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=an7owiFu8v0A:10 a=8nJEP1OIZ-IA:10 a=znT3HYeYn0u1vGJIbmIclg==:17 a=-AnQz9JOAAAA:8 a=if_YyohPF_xpXwSyScsA:9 a=M99rn7SpJl7-N8im0z5AWUTmBRUA:4 a=wPNLvfGTeEIA:10 a=znT3HYeYn0u1vGJIbmIclg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 184.91.185.153
Received: from [184.91.185.153] ([184.91.185.153:47334] helo=[192.168.1.2])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 95/29-07087-C89A60D4; Mon, 13 Dec 2010 23:17:32 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20101213192053.GA30315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163603>

On 12/13/2010 02:20 PM, Jonathan Nieder wrote:
> You might be interested in girocco's fork support.  See
> http://repo.or.cz/w/girocco.git/blob/HEAD:/jobd/gc.sh for starters.
>
> (Yes, the short answer is "-l" but showing where I got that answer
> from seems a little easier. :))

Yes, -l looks like exactly what I need.  Now I don't suppose there is a 
way to make it sticky so I don't have to remember to use it when 
repacking every time?  :)

I checked the man page for git-config and it doesn't show an option that 
sounds like it.
