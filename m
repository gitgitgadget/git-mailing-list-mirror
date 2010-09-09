From: Carlos Eduardo da Fonseca <eduardongu@gmail.com>
Subject: Tags only shown on log with --decorate?
Date: Thu, 9 Sep 2010 14:25:30 -0300
Message-ID: <AANLkTimOEQY9xJvindxuVPZotmWXZ=Ya9088ghL--Xuf@mail.gmail.com>
References: <AANLkTikgxMFoiQm31FXgqBth=enVxxgxDJv8_97C30HF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 19:25:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtksW-0007KD-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 19:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0IIRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 13:25:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54874 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab0IIRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 13:25:31 -0400
Received: by vws3 with SMTP id 3so1530763vws.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=i857soQX01GWWIgue7YhcvAp7Ij05tlTjeGrVdf+c8s=;
        b=Qbg9ogMs0RiS2e8jFzzDhY2dBE5wpCXyyY/ogRFlBfFfQEbuRYPJyEAqWx8sw2Ii8y
         yXKwTNl5xpSRqqIgDwOIT0xfs5VD6Bh6wg1rSQj3u6PwSyD8OPirzrGQesdQxaHqVDq6
         vPFL7+jk5aLpV8dancQs5Q5F/SrlAlQw+hEJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=BT4U2soI4G+QcjJIw7nmSsAsuMwg0ZecnhCHxihp9PE2b2SKbIVfshljbs8FBb8gvp
         wWKcWmj6fVvGKXt6e99bA0FgKkJYjrFDxZsJ/FaLCg36i4YwShSD0Sb3N5SkyFafbecy
         /0yGRhgXD87aY/+aOYdIjjTRRqIwtYZdJKMyg=
Received: by 10.220.63.75 with SMTP id a11mr62603vci.208.1284053130350; Thu,
 09 Sep 2010 10:25:30 -0700 (PDT)
Received: by 10.220.111.18 with HTTP; Thu, 9 Sep 2010 10:25:30 -0700 (PDT)
In-Reply-To: <AANLkTikgxMFoiQm31FXgqBth=enVxxgxDJv8_97C30HF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155868>

Hello,
I was wondering, why tags are only shown on log with --decorate, even
signed tags?
I have no problem in writing "--decorate", but tags, which are marks
for something important, should be decorations?
Thanks,
