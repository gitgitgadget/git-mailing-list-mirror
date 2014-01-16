From: SH <saajey@yahoo.com>
Subject: file permissions in Git repo
Date: Thu, 16 Jan 2014 15:58:57 -0800 (PST)
Message-ID: <1389916737.92225.YahooMailNeo@web124906.mail.ne1.yahoo.com>
Reply-To: SH <saajey@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 17 01:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3wwQ-0006hr-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 01:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbaAQAFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 19:05:35 -0500
Received: from nm11.bullet.mail.ne1.yahoo.com ([98.138.90.74]:23745 "EHLO
	nm11.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298AbaAQAFb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 19:05:31 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2014 19:05:31 EST
Received: from [98.138.226.177] by nm11.bullet.mail.ne1.yahoo.com with NNFMP; 16 Jan 2014 23:58:57 -0000
Received: from [98.138.89.232] by tm12.bullet.mail.ne1.yahoo.com with NNFMP; 16 Jan 2014 23:58:57 -0000
Received: from [127.0.0.1] by omp1047.mail.ne1.yahoo.com with NNFMP; 16 Jan 2014 23:58:57 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 947517.80124.bm@omp1047.mail.ne1.yahoo.com
Received: (qmail 2562 invoked by uid 60001); 16 Jan 2014 23:58:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1389916737; bh=fy5HufTKmK7TZfBZ6ExJ1AxeDRJ+kw+zwLTtIjMMpHI=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=cQMhh+mUia+fpybr9+39WeUfqHPZedDtA+x8HD14XbdbFr3vTpqA7Ajhzj3MUgtfFjoUKM89Z3n3OWtfXL18PB9j99A6vQ39lb/Xs1W7egomSlCp73RwvMmI1XlW9lhmzbyalHqlVjyz5idrtugWr0IOtK6y12IqF2TNjSQQukU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=rozB2OhbFHxZL5IARrERrLMUI161aOlm0NQGIEwQU7uVj7Tl2tHMlhrT8tbLmpN9ZEmYf0eaKpB5KKqE/LuihzLb+ka6E14RcOidCw7JZRXTJVtTRAOL97RmMfptCxw+l2KsalNVDSNr/R9s9jl9o6UPjIBgN68277JHls6wJr8=;
X-YMail-OSG: _Lf6m6kVM1mm4tAt4Ntmr6cI82QR6Bd3v2ZoaiMbnUi7RAm
 iafnVFCzeP__ncUP7sy_waWsW7puwS8SIYQ.UhzWg2SvTezWoM9zu3TV2eeq
 iz1RJy7akSDYB5FudlwwX7uMEx75tgSzrcuYhezEIFHdzfTtO_WEsUiBWmTf
 S5JRCHgIYXsFmF9Wk4yYeCeNdnujPwXvglL6vrbuMYjFxg8PQo8btNET8Tgl
 u18iA3FEsXzpf0N_mMWnLamKoBr_6431Ipx601yeft8KnOpLDX3GpmsZd_rm
 rtEcS9w_HwNaEoPXHOi8z8m7vCUz9n9Y7wwQ9LiyfnZI.sVLE2RMe5WgKNpE
 yVwb.EBwe8xLUrNj8jdK2b2I8KcBKeFDlh9MsDsMUNJRR1FlilCXU3Q4nIhc
 zj92cfA1uagyAyfdikjd_lbrzDMqDNIlfIzX6_vatV5rhB68ZWth42V2biHj
 EuAPk8I5t8hkra7UqtcaFNkC11qKYR1FBPuB6hlAkgdDCvkFfJzpcZToq1dg
 Dt90MOuPSBFe0x7Fb0HColwmUPQH9v45j2YcYXSHSSR_PshLlmcmhNixpSeG
 1RACqIuOJMQt4gT8NWHTzRLzBDA--
Received: from [70.42.18.1] by web124906.mail.ne1.yahoo.com via HTTP; Thu, 16 Jan 2014 15:58:57 PST
X-Rocket-MIMEInfo: 002.001,CgpIaQoKCldlIGhhdmUgYSByZXBvc2l0b3J5IHdoaWNoIGhvbGRzIGxvdHMgb2Ygc2hlbGwgYW5kIHBlcmwgc2NyaXB0cy4gV2UgYWRkIHRoZQpmaWxlcyB0byByZXBvc2l0b3J5IChmcm9tIHdpbmRvd3MgY2xpZW50KSB3aXRoIGV4ZWN1dGFibGUgcGVybWlzc2lvbnMgKHVzaW5nCmN5Z3dpbikgYnV0IHdoZW4gd2UgcHVsbCB0aGF0IHJlcG9zaXRvcnkgb24gYW5vdGhlciBtYWNoaW5lICh3aW5kb3dzIG9yIGxpbnV4KSwKZmlsZXMgZG9udCBoYXZlIGV4ZWN1dGFibGUgcGVybWlzc2lvbi4gQ2FuIHlvdSBwbGUBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.173.622
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240547>



Hi


We have a repository which holds lots of shell and perl scripts. We add the
files to repository (from windows client) with executable permissions (using
cygwin) but when we pull that repository on another machine (windows or linux),
files dont have executable permission. Can you please provide a solutions for
this?

We also tried post-commit and post-receive hooks to set the permission but
it didnt seem to work either.


Thanks
