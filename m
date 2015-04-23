From: B M Corser <bmcorser@gmail.com>
Subject: Odd rev-list behaviour
Date: Fri, 24 Apr 2015 00:48:43 +0100
Message-ID: <CAPR6cbD5uFoCDg73wqSQEPOuUEjsy6963QQsePwofxVTuBW8Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 01:48:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlQrR-0004ke-3e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 01:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030959AbbDWXso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 19:48:44 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35431 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030875AbbDWXsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 19:48:43 -0400
Received: by oign205 with SMTP id n205so27993861oig.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VFq0Dc2OgZb2dB8/h+xm68SFknxUarmasdAEutW1H8Q=;
        b=xJnNVPCxSf+rhrqJOpR0+qIHtNLzEL7scorQ+2qGSbWPCiVDz7Unwdqaje1PFzv6Db
         dGq92i5s7scNaU4//ZWc4RXPD6BYCGH+K7cFrfe/fT91ag7fOPt0MJMCvgJInuU4ObDo
         7peKUvNTEG3tJYgjWjjYBRcuYs+qMLsXL8OeQLiV0lLx/+KOTDpNsOZWxluirjkWeXsi
         b1+6goR6iJ1/UsCb5zlwwxUTSM1iWF8WfTWC340aqu80jBkfr1XRokwsUxF+Nrze2D5a
         HCsk5SGi9uAsIr2lsOmGi6ghY5npzbTKXOoe7zYFOyDabb+Sw3r6xo/U4AA0VpMgLnQU
         zIOg==
X-Received: by 10.202.203.204 with SMTP id b195mr4571271oig.1.1429832923260;
 Thu, 23 Apr 2015 16:48:43 -0700 (PDT)
Received: by 10.76.158.164 with HTTP; Thu, 23 Apr 2015 16:48:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267713>

Seeing some weird results out of rev-list, see my demo repo:
https://github.com/bmcorser/rev-list-fail

I was after a one-liner to sort a bunch of commit hashes into
topological (or date) order. The commits were made by a script that
forges the commit time with --date in the hope of seeing stable
results.

Any ideas welcome,

Ben
