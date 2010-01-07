From: Eugene Sajine <euguess@gmail.com>
Subject: origin/branchname and tracking branch pointing to different commits?
Date: Thu, 7 Jan 2010 12:03:45 -0500
Message-ID: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvmL-0000vd-At
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab0AGRDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185Ab0AGRDs
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:03:48 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:61822 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0AGRDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 12:03:46 -0500
Received: by iwn32 with SMTP id 32so2464113iwn.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fwP6VklBkiE9NxqhOfie5ocODTIHgHYamfotEuQqFXA=;
        b=lSKbctxF8dhHTdxLZHfoC2vPuGEbccyyyBISvO7ad+9dcl4W19St12zuPFfK0XFJth
         wg7qatZCDrJeSZ6df0GhL0hN8DALqZFT2g9As1I9JadcntlyDA3sr3UaX/5VZrc+vmYo
         IAOxETrj//mV4eS816bVFW53pqlVuOJ+muDt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=f8IhLUwmetHVr4RSzAIk/NO7FUvM77IhdzV288KxgDhgmSy5O4ayINMyy3WHsgjEZW
         GzYaq14G7Pcwi76Ry3+JEqVGpzhJZJr375AatlymU69CQP3Jadho+0mFrzKG2I8JGa+n
         imefLQAwDPwbaUGuvfBNyiyZlNRh+froOO4gM=
Received: by 10.231.29.149 with SMTP id q21mr799912ibc.35.1262883825732; Thu, 
	07 Jan 2010 09:03:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136358>

Hi,

Could you, please, help me to understand how it is =C2=A0possible to ha=
ve a
tracking branch named qa which tracks origin/qa both pointing to
different commits after git pull origin qa?

I.e. I currently see this picture in my repository when

$ git co qa
$git log

gives me qa branch history advanced by 4 commits comparing to origin/qa

while

$git pull origin qa

says it is already up to date

So, generally, speaking qa branch is fine and is in synch with the
remote mainline, but the state of local origin/qa is not clear.

Thanks,
Eugene
