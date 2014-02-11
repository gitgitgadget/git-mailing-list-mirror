From: Cameron Taggart <cameron.taggart@gmail.com>
Subject: feature request: text=input option in .gitattributes
Date: Tue, 11 Feb 2014 08:57:35 -0600
Message-ID: <CAABik=sZowhZ4hMi6R=KQHWT_FGBJ9iXJEjtX26wueCzjEQL7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 11 15:57:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDEmK-0004wk-5O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 15:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbaBKO5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 09:57:36 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45558 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaBKO5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 09:57:35 -0500
Received: by mail-oa0-f51.google.com with SMTP id h16so9304574oag.10
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4yJesG3eLVy0pDVBfze9xyrwSkAohUiW1SuOPLf1vGo=;
        b=tNjRnrhcp9yCxVPiVmPdWgq6nAdlKIW8UkDJwxbYFVkt92kmJ9rSgCaFreaml7bHgO
         0pHBfCnsBAJSgb/NO35OBI+xOZ1zFbavQ/sZqkmp1n6/AJL0EFvuwqbXWwQtLrGtt82P
         BL2ni6gwXNI9MpaoFYT0NC50+96pxB7lRU45EmuV9c+D/j+925ldLA2+fDp1KGVw+rMz
         CKyZti3x+DBdmMwUOfvCCR2dBjgLDdMABrlkDey+USKmvjb+SabOiBG5p34dm4f3G5M0
         1ivCTgPSHqbNSFNLhQjaaV5fhofZHU5jv3/qrLCNNARbqFefx8jUTMJtnioysQMa9O6h
         Z1Tw==
X-Received: by 10.60.52.138 with SMTP id t10mr746956oeo.59.1392130655272; Tue,
 11 Feb 2014 06:57:35 -0800 (PST)
Received: by 10.76.153.228 with HTTP; Tue, 11 Feb 2014 06:57:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241945>

After requesting this as
https://github.com/msysgit/msysgit/issues/164, I was told to take it
upstream, so here I am.

I would like a text=input feature added that has the same behavior as
text=auto, except that it defaults to core.autocrlf=input behavior
instead of core.autocrlf=true. This would ensure that the repository
is normalized and the text files in the working directory match what
is in the repository by default. In mysysgit#164, I highlighted the
behavior changes in a spreadsheet. This would still allow users to set
core.autocrlf=true if they want CRLF on their Windows system. Using
text=input instead of text=auto would ensure that Windows build
servers like TFS and TeamCity compile libraries with code that matches
exactly what is in the repository. This in turn, would make it much
much easier to do source indexing using my SourceLink project. :)

thanks,
Cameron
