From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: git diff --ignore-submodules fails if submodule is inaccessible
Date: Mon, 25 Jun 2012 18:01:36 +0300
Message-ID: <CAGHpTBL=hHazYv09KxADi3xa5s1TM2KNFteg4E=uW0WYDy_kxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 17:01:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjAnO-0006HF-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 17:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab2FYPBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 11:01:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37623 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab2FYPBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 11:01:38 -0400
Received: by lbbgm6 with SMTP id gm6so6611479lbb.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Igird3EH5A1wHnCLjFm2wMoZ+ecaLN2gFkEjX/Tfwvo=;
        b=jjq1XRDy7N0AbM4WCWE00gtvX1/EJT1YBXZglCLtPvZLHq175SgIMtuGb3V/B9mXdk
         QH8Sk7kXn80Ufrof5te1UxAQ+xz9s5meqYDGFrWhpH8g+quCwrxWgF8zSpgyxc3NnFyx
         2Z1GqEP3Ol5pDU1o53GRRvxVGY+tr3v/nhHfeCTX3A0weusJmJBpBkV8Zj09+VK4QAXv
         Ne6d+DmUTs8fZCqXlR5Rkyk4EkMopF36vMRwgofwPPx92HURM6ott365GYo3jDCln7Wi
         wP6mFjN4OByak7MiWb3h/5Aa0pLyBmYcfglcai2J4HEza4OiIttVKyEIyAY0xX/E6rPp
         oBiw==
Received: by 10.112.86.105 with SMTP id o9mr6049341lbz.32.1340636496891; Mon,
 25 Jun 2012 08:01:36 -0700 (PDT)
Received: by 10.114.17.35 with HTTP; Mon, 25 Jun 2012 08:01:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200582>

Hello,

I have a submodule set up with a gitfile which points to an absolute path.

Trying to access the superproject from the network, running 'git diff
--ignore-submodules' yields 'fatal: Not a git repository:
<submodule-absolute-path>'.

It should really ignore submodules when requested...

- Orgad
