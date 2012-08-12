From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: mark progress strings for translation
Date: Sun, 12 Aug 2012 18:42:26 +0700
Message-ID: <CACsJy8Afhu+kaou6J_Ts5u0ffP+_5wF+1+rc5H2o5rY23vnJeg@mail.gmail.com>
References: <1344684304-22425-1-git-send-email-pclouds@gmail.com> <7v8vdkhgqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 13:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Wa7-0006zU-ML
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 13:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab2HLLm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 07:42:58 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44579 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2HLLm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 07:42:58 -0400
Received: by obbuo13 with SMTP id uo13so5214862obb.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n+VnSUs5M4EqrCkS2y++XdwiKKXLn/Z+C4Ft223LlWU=;
        b=sNUSf1mWNSfzqf+DJJrML6aaTEcwUH3dXvyulaeH1iCSkzJp91J4Dm/ZnRT0G7gqaj
         qkQbxw6nMBprOfTPcxF0oi5y+37tfmb7O+PTf8NWMv+V+0NPjRCFVbxQ8s3BV212IGcY
         R24JcETSylvZcdOIQxKoYYY6OBuMJR954LTQmwdncZSPj7wLvGDzrnig6crBOVDCMg82
         VUWRsk2DHcaFE0dABTfr6gD2Xyp9DJYUAUceWSJZroKIsx8Lho/gYhLTQDCIHBh802QE
         yX4o/ec81M+Pxjco1Xb+R5S1tYrYP+OJX17BPWOeJYRySxNu8XWml+3deMM+kK6qyj6w
         LK/A==
Received: by 10.50.193.201 with SMTP id hq9mr2684144igc.48.1344771777438; Sun,
 12 Aug 2012 04:42:57 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Sun, 12 Aug 2012 04:42:26 -0700 (PDT)
In-Reply-To: <7v8vdkhgqb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203307>

On Sun, Aug 12, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I personally do not think this makes much sense, as half the
> progress message you see comes from the other end of the connection,
> which does not know nor care what language you speak.

That's something we should fix too (either make it entirely in English
or a native language). Still there are commands where all progress
messages come from local side and it should not show "done" in English
in such cases.
-- 
Duy
