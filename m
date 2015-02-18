From: "Martin d'Anjou" <martin.danjou14@gmail.com>
Subject: gitk drawing bug
Date: Wed, 18 Feb 2015 14:27:58 -0500
Message-ID: <CACZ2eqdm_DXfa0o9J3NXfxD0XG-iAbPNUhySg026qhkqZAYWJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 20:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAHz-00071g-IS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbbBRT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:28:00 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49472 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbBRT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:27:59 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so4502062wib.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 11:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CR3tutUyawAe7iOpE4cjH+KOfZAvgKkvgtKb6G1uQOw=;
        b=kVA9r5nIPpBkQ0rVUDuRNFwCEfjZJlTVlUvcPWMCAV/KZKD+eIeGtDeqqEuYHjhwn/
         Mth4IyOb4c9P9ZrEKNuhZ37DTH3N30L3j3oPdVPZhpi9PjKh6WxbKKlgVHeoNkYJsNzu
         xCrFZvJkosbbOXZcv7xKZZH7BJHphTcNKVr7AQiRxPqmUVi3b1D/3oMnbQc+4sNpT5TD
         MgFR6bTNEF7WmpPKYAvKIJgARPoWb8SjFrLT8XRrCjX3gQpzCoQsUwwrzzZD8mYeM9LK
         9mdtd4zgc+Wxy/9IveYobH39AA9gpVE3ZdAZGSs8bHMUaSowGrgec2Et0AmRy80cLOnu
         tr9Q==
X-Received: by 10.194.57.199 with SMTP id k7mr1666204wjq.1.1424287678092; Wed,
 18 Feb 2015 11:27:58 -0800 (PST)
Received: by 10.194.109.99 with HTTP; Wed, 18 Feb 2015 11:27:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264055>

Hi,

It appears I have uncovered inconsistent behaviour in gitk. Looks like
a bug. I have a picture here:
https://docs.google.com/document/d/19TTzGD94B9EEIrVU5mRMjfJFvF5Ar3MlPblRJfP5OdQ/edit?usp=sharing

Essentially, when I hit shift-F5, it sometimes draw the history
differently (still valid, but drawn differently). There is no change
in the repository between the shift-F5 keystrokes.

Thanks,
Martin
