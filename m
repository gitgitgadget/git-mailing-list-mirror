From: Eugene Sajine <euguess@gmail.com>
Subject: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Mon, 21 Jun 2010 17:34:13 -0400
Message-ID: <AANLkTikcnv2dzY25dSgvKoTfLJ416gcaeDZA5HGa_tue@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 23:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQodH-0001aJ-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 23:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653Ab0FUVeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 17:34:15 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39081 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612Ab0FUVeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 17:34:14 -0400
Received: by gxk26 with SMTP id 26so1136711gxk.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=qPQSqNYoO/fjIsjuIVKryFQFva3Q97mFCT6GBJxhl2Y=;
        b=i0HBXhNE0WoXde7+8clu2jgs6s0biQG3wPo/AWJIytmlKha/qwGg1S78Tv3u3Kaya4
         6u2wlvfusdJXqRywyladttAtXODE7PLVcOGzp8uQBmAKr44jV4IN+hQG6nc7dzW2OO7d
         TqKiala+GrOfvqxwA6UlRkvfHsd14cAOgo99c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=K+rpwYtUAAkoyrI5Ayr/dMMdeFSBAW0B6NvF3WIIHcOHTSHrB6IhiKN/zm78DvoPcK
         Qqx+YUQHI2E7UcUOCRVaCCoSAIgPcocUZ31V2SoJrZM0wezlBhtefWY4jdVXjXRBf6dm
         ZGxx8bf+qTYTIo5c3x/mj6OGoFxt1DAd7ornY=
Received: by 10.229.248.11 with SMTP id me11mr2824554qcb.86.1277156053189; 
	Mon, 21 Jun 2010 14:34:13 -0700 (PDT)
Received: by 10.229.190.21 with HTTP; Mon, 21 Jun 2010 14:34:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149442>

Lars,

Could you, please, advise how can i switch on some logging in CGIT so
it will trace all activity and tell me if there are some errors?

The problem i have is that some repos summary page is not getting
shown properly. I see only branches, but i see no Tags, Age or Clone
URL.
apache logs are not very helpful.


Thanks,
Eugene
