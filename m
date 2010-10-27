From: Eugene Sajine <euguess@gmail.com>
Subject: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 12:46:00 -0400
Message-ID: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 18:46:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB98e-0005AX-85
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab0J0QqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:46:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62839 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0J0QqC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:46:02 -0400
Received: by gyg4 with SMTP id 4so534505gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oSm/MgOCVsDglSPGUi8VOQ3Apm/3MDCwfNj0MKGvmHo=;
        b=hETbo/MNQDyE0xZOHbJ1A7jI7YLWV2wmtYRtycR/ziXtRh3DyfJ4cr/I76Yc5UNg8P
         icmnZrlKYCVbHgOdDCk4M0Ix2LrrQpi3BrR7ENDmS42IxUnMXlIqpB/GxL7BlynlhKmS
         bOMHwCeVocdKJJNrkHNGom3DfflzuKVLiFim4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Yjh7nA93K1NVF7A+cVSLGq4bJM+UDSlFqG4cl141FxqS27ZrvrP0SSoP+4ApRslMKE
         KZmOW2mPcNQ6HxpVw//wuCyMFNlm9xHtiAe1ypn+HRloVpvZiXWLgoDn8FBUFIeq15ri
         GZQjzhJ7dHc8oBDmYoFr7mMlNTapOcixydMPI=
Received: by 10.204.98.84 with SMTP id p20mr7546570bkn.213.1288197960734; Wed,
 27 Oct 2010 09:46:00 -0700 (PDT)
Received: by 10.204.46.207 with HTTP; Wed, 27 Oct 2010 09:46:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160099>

Hi,

I'm just curious if there are some downsides that i don't see?
For me it seems to have much more sense to automatically rebase vs
merge when you do pull. The diverged history will become "straighter"
and cleaner, if the history is not diverged then it will be
fast-forward. So, why not to rebase?

Thanks for your time in advance,

Eugene
