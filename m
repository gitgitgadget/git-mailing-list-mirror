From: "Yutaka Kanemoto" <kinpoco@gmail.com>
Subject: [PATCH] Add git-gui--askpass to git.spec.in
Date: Wed, 5 Nov 2008 02:15:33 +0900
Message-ID: <56069dac0811040915p52a18cc2uc6a3706733a4d9a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 04 18:17:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxPWb-0002Tg-3M
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 18:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbYKDRPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 12:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbYKDRPg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 12:15:36 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:8829 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbYKDRPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 12:15:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1220456yxm.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yUUM8Gtw8TASXCLkpqjXO/gFcD7yWWvHqHyfXgo2+0s=;
        b=YNTIT0As0IShI1pII2Fuz+W1tZSqxXLXXJeADH05/za96Ylzdd7o0cxkYGY7Fbw81f
         W2sedb2HV9PuVPsaaUNYMa0L8FsWnrpGKSa31nrkUpkEywQwJeRRWtqXk4+gKeSDOIZ+
         XcDpKuc2yVQkcKSHjugTavvtGFkK90xkbyjyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gSvS/PyJX9csbDuT2FOtj9HjRwpJWzYIVY58wr6RkSbBudlI8TcJvqPOLyIQJ5QOhB
         YtgIklu+JqSiYRNIRmwU5+uFRzOoEY/4a65ASvA8TBA+hPoNo/pmWQ9asY8zdpcRdRGB
         AFEBjpywNH25MV/bKBdemoOHPYLxtqAlpBCsE=
Received: by 10.150.191.10 with SMTP id o10mr2778711ybf.90.1225818933824;
        Tue, 04 Nov 2008 09:15:33 -0800 (PST)
Received: by 10.151.38.7 with HTTP; Tue, 4 Nov 2008 09:15:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100091>

'make rpm' will fail because git-gui--askpass is not listed in git.spec.in.
At least, I was able to create rpm using below patch.

Best regards,
Yutaka KANEMOTO
---
 git.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 6733b6f..bf7fa63 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -167,6 +167,7 @@ rm -rf $RPM_BUILD_ROOT
 %files gui
 %defattr(-,root,root)
 %{_libexecdir}/git-core/git-gui
+%{_libexecdir}/git-core/git-gui--askpass
 %{_libexecdir}/git-core/git-citool
 %{_datadir}/git-gui/
 %{!?_without_docs: %{_mandir}/man1/git-gui.1*}
-- 
1.6.0.3.613.g9f8f13.dirty
