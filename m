From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: More support on branch description?
Date: Thu, 19 Jan 2012 21:14:55 +0700
Message-ID: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 15:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnsmI-0003Nv-MA
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 15:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2ASOPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 09:15:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43643 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2ASOP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 09:15:28 -0500
Received: by bkas6 with SMTP id s6so3800359bka.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 06:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=/tBECvWrLRufywTfLjbB37tdzSqeTbIsWiY1p2n3u0I=;
        b=P1MuwF9PVZoF/I2HGCYCu4SpZgfQzkO48UzPALFfjU+bdKp+Wtu3t9q93SNqDr8O7t
         1p/zb/4QU6PiXj0c2puUHy7KZrpv4U58wF0tWHUPo8Tkh65/kVD4U9pGKnarXHt3CR1P
         SQZ7dqohJWJx7lqnJN9hosY0XXP7KSMUCOEfg=
Received: by 10.204.128.197 with SMTP id l5mr10491899bks.58.1326982527220;
 Thu, 19 Jan 2012 06:15:27 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Thu, 19 Jan 2012 06:14:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188812>

Hi,

The coming v1.7.9 will introduce branch description, mainly used in
integration process. I think we could make it useful for users who
don't extensively use request-pull/format-patch. Showing a short
summary along with branch name in "git branch" would be nice. "branch
-v" is already used for something else, maybe we can come up with
another option, or "-v -v"? Another place we could show branch
description is "git status". What do you think?
-- 
Duy
