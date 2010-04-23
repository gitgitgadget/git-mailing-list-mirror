From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Fri, 23 Apr 2010 11:12:01 +0530
Message-ID: <w2qe72faaa81004222242rdc1b5ceaw71eaecaff0f6fc76@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004202014.19477.jnareb@gmail.com>
	 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
	 <201004230727.52212.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 23 07:42:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5BeY-0001kB-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 07:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab0DWFmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 01:42:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:40345 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799Ab0DWFmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 01:42:04 -0400
Received: by ywh32 with SMTP id 32so5411059ywh.33
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JycekSsJ3lb+64QY4sJwlOVf7DzQoDZti0TiuYDWf/8=;
        b=fpSdU3/AQaY7EIK/IIJckweERgcUC6a9oB/6/7+HjdCcLD54YpLj577epMFx/SnCM+
         ghYsmCZqZABsO+6gqN0zOG4C6eb2FerGBcNDGQl65flaP7fuwfIJkaSV/gZcpQzHfgS2
         3IVi4v+inX5dpLW8EHagwjridZA7XyMHrHSDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GsAu/n7VaT+gdzkTUCnc0Aw9sOegIbPaFg0W1au6uG0FVomN51GkhcS6zXDnbgTNwd
         38maNVctWfHO0Tk8XgCzJO6MB2nG149yPbG2JetjJdtIRGYGKcqcB/iVZB3dyoRDyYjU
         kiDp375jiUgp9Lt5RhLZDzxecrXxdXFlDgrIc=
Received: by 10.90.99.11 with HTTP; Thu, 22 Apr 2010 22:42:01 -0700 (PDT)
In-Reply-To: <201004230727.52212.chriscool@tuxfamily.org>
Received: by 10.91.146.20 with SMTP id y20mr5663254agn.19.1272001321935; Thu, 
	22 Apr 2010 22:42:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145588>

On Fri, Apr 23, 2010 at 10:57 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Wednesday 21 April 2010 22:49:02 Pavan Kumar Sunkara wrote:
>> 1.What is the goal of your project?
>> The project goal is to try and implement write functionalities into =
gitweb
>> to go along with it's browsing functionalities. Another goal is to s=
plit
>> gitweb Perl script and reorganize its structure. I would like to spl=
it the
>> gitweb script in such a way that, in the future others will be able =
to
>> develop more functionalities for gitweb (let it be 'read' or 'write'
>> actions) with the help of the framework like structure of the new gi=
tweb.
>>
>> 'read' means browsing through the code and repository
>> 'write' means working on the code and repository.
>>
>> I will be describing about them detailedly in the later parts of the
>> proposal.
>
> Perhaps this sentence could be worded like this:
>
> "I will describe in detail the read and write actions in the later pa=
rt of the
> proposal."
>
>> 2.How would you measure its success or failure?
>> There are two parameters which would majorly determine the success o=
r
>> failure of the project.
>>
>> =A0 =A0* Splitting gitweb such that there should be no problem with =
the
>> installation of gitweb across cross servers and cross systems.
>> =A0 =A0* Working with new addition to gitweb should be as easy as wo=
rking with
>> other git GUIs (git commit tools)
>> =A0 =A0* User friendly graphical interface with smart UI design
>>
>> 3.Describe your project in more detail.
>> I would like to split the currently 6800 long piece of code in
>> gitweb.plperl script into small files which will result in better
>> readability,
>> maintainability and modifiability. The file structure of the new git=
web is
>> given below and I will explain the working after it.
>>
>> (From now on, I would like to call the actions of gitweb as modules =
of
>> gitweb)
>
> Perhaps it would be better to state that in the end each action will =
have its
> own Perl module.

Thanks. As I said before, Sorry for my grammar.

> Though I agree with Petr that first you should probably just shuffle =
around all
> the utility routines in one module and develop write actions in anoth=
er module
> that uses the first one.
>
> Thanks,
> Christian.
>
>

Yeah, I am planning to do that. :-)

Thanks
-pavan
