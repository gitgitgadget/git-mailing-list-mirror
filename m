From: demerphq <demerphq@gmail.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Sat, 29 Aug 2009 00:16:10 +0200
Message-ID: <9b18b3110908281516w463522b3pb3562b8f0cb9fb03@mail.gmail.com>
References: <vpq7hwo8gxd.fsf@bauges.imag.fr> <4A979690.1050601@gnu.org>
	 <vpqk50pasek.fsf@bauges.imag.fr>
	 <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
	 <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
	 <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
	 <9b18b3110908280912o271dc095o67bc82b31e91680e@mail.gmail.com>
	 <alpine.DEB.2.00.0908281443070.28411@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: seanh <seanh.nospam@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Aug 29 00:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh9r4-0005mj-Ht
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 00:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZH1WXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 18:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZH1WXY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 18:23:24 -0400
Received: from mail-ew0-f227.google.com ([209.85.219.227]:37955 "EHLO
	mail-ew0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZH1WXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 18:23:23 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2009 18:23:23 EDT
Received: by ewy27 with SMTP id 27so2685344ewy.40
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kOOsiFdEkMdbroJflD3X1AiEqNPLwK5rSgfvaxXCnE0=;
        b=Gs7gSe18HV6XhXETY/9h/Ze/7AoNOgCw2/If8/UV1m4ciu8rTW1xyg0igcIgNhq+Gw
         Kl+1d69z8kDQQ3YkdhBavPVpb3Seh+HaW0EDrLggluuED+TgqSJtx0u/DIfWy4oc7ksS
         /ifBncdIfwLG/L1eP9HMe5JLhrJ/GrPn0fTcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sJ6nBIGXrUcBvvKiIP/mYxhejSWVNCLiC40waRVRmCa/1gNV0Tg00pUcEP7zwUX/PL
         DwfNw9OP82U4vz1KKyeVkZ1Gh8yOcw0XQps1kQ2+/I04L6w1pxoouhTrZ1MTtsevLcmX
         IV0rdABo9eVFwEwkBX9HqCtrE7wK8GmBr+NFM=
Received: by 10.216.87.68 with SMTP id x46mr349459wee.2.1251497770157; Fri, 28 
	Aug 2009 15:16:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908281443070.28411@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127357>

2009/8/28  <david@lang.hm>:
> On Fri, 28 Aug 2009, demerphq wrote:
>
>> 2009/8/28 seanh <seanh.nospam@gmail.com>:
>>>
>>> On Fri, Aug 28, 2009 at 12:21:42AM +0200, demerphq wrote:
>>>>
>>>> As you can generate the PDF's from the latex then just hack gitweb=
 to
>>>> let them download it from there.
>>>
>>> Unfortunately gitweb is written in Perl. But I know what you mean, =
it
>>> should in theory be possible for them to click on a 'Get PDF' link =
for a
>>> particular revision that causes the PDF to be built and returned to
>>> their browser.
>>
>> What is unfortunate about that? Perl is a duct tape/swiss-army-knife
>> of the internet. =A0Hacking gitweb to generate PDF's on the fly from
>> latex documents should be a fairly trivial hack, even if you aren't =
a
>> Perl hacker.
>
> I have a situation where I need to generae pdf's from files that are =
under
> git. I have a git repository on by webserver that I push to and have =
a
> trigger that regenerates the pdfs any time there is a push.

Actually this discussion makes me think that there is room for a hack
to gitweb to provide extensible and pluggable renderers of the files
in a repository. Such a framework would for instance provide for
syntax highlighting, PDF generation from latex files, etc.

Hypothetically it wouldnt be too hard to do. A Win32 (dare I say)
registry of file extensions/shebang lines would be linked into a set
of renderer plugin's, which in turn would automatically add the
required links to render the file as needed. Quite doable actually.

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
