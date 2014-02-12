From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: feature request: text=input option in .gitattributes
Date: Wed, 12 Feb 2014 16:56:21 +0100
Message-ID: <52FB99A5.9040607@web.de>
References: <CAABik=sZowhZ4hMi6R=KQHWT_FGBJ9iXJEjtX26wueCzjEQL7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Cameron Taggart <cameron.taggart@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=22tb_=3E=3E_Torsten_B=F6gershausen=22?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 12 17:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDcLw-00049o-VX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 17:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbaBLP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 10:56:27 -0500
Received: from mout.web.de ([212.227.15.4]:54163 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbaBLP4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 10:56:23 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MbyMU-1Vwdoh49Li-00JHre for <git@vger.kernel.org>;
 Wed, 12 Feb 2014 16:56:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAABik=sZowhZ4hMi6R=KQHWT_FGBJ9iXJEjtX26wueCzjEQL7w@mail.gmail.com>
X-Provags-ID: V03:K0:DE0Itt/BtTceDefed1L3MDp/PT/bonKzvmW7YtLLK6/7etyuj32
 dJ7heyGVIx0T16xQGk7vprCs9zoPngGh5VnrwjatuezhHus5ZPwrE34ROnK2JpaK6l1iHwr
 od+s1Wou2tZekzjQeqU/SkZnkAuhTDbyAWTpbBr3DB9aYKpkVFwLdRAlikZyweaVYExnEV6
 EgJYXX3O/vOGdLoMGZcZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241995>

On 2014-02-11 15.57, Cameron Taggart wrote:
> After requesting this as
> https://github.com/msysgit/msysgit/issues/164, I was told to take it
> upstream, so here I am.
> 
> I would like a text=input feature added that has the same behavior as
> text=auto, except that it defaults to core.autocrlf=input behavior
> instead of core.autocrlf=true. 
If you want to normailze your repo, and keep it normalized,
I can  recommend to use .gitattributes.

Please see the excellent page here:
https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
And especially this part:

$ echo "* text=auto" >>.gitattributes
$ rm .git/index     # Remove the index to force git to
$ git reset         # re-scan the working directory
$ git status        # Show files that will be normalized
$ git add -u
$ git add .gitattributes
$ git commit -m "Introduce end-of-line normalization"



/Torsten
