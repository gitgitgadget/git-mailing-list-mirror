From: Duy Nguyen <pclouds@gmail.com>
Subject: Make GIT_USE_LOOKUP default?
Date: Sun, 17 Mar 2013 20:25:55 +0700
Message-ID: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 14:27:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHDc4-0001Rj-Hm
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 14:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab3CQN00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 09:26:26 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:61803 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3CQN0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 09:26:25 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so4840905oag.10
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=f3DgfjMTCE0uSjaKmC3m8zaI3K4ZL6EjYz5s4Rj5vFE=;
        b=ppucH5tRxQsxRd4c7dKPOnhRiXLPsOeiJf0+OJX6VgXAfsEXiW6sMdxDYxAp5Az19k
         QlQdEEG2K+zLeK78pdlBoOOc0USb/3nmcu2rVg+p9CYTpP+GIIScW0krDm7L1zRjntvd
         ByDUQfIG8lWR2mw9jG+541DD1ZwjoQOBV1B7nGlPIKiCDNL1TpEjoGMVtBIRaFc82es6
         KjN3aT2znb5xKnC9H2me6CrSpQl/dLVxcmMAQ41OZ+Rm2qruivBYyJrZopHXuHa4OQpv
         FWoApy5J3ZU5CeAlIU31p9d3EcaQIqQkjrNc58gMpYYwpREbKCnnHNfFt84cm9e+JPUH
         gpcA==
X-Received: by 10.182.43.103 with SMTP id v7mr5463885obl.17.1363526785399;
 Sun, 17 Mar 2013 06:26:25 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 17 Mar 2013 06:25:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218363>

This env comes from jc/sha1-lookup in 2008 (merge commit e9f9d4f), 5
years ago. I wonder if it's good enough to turn on by default and keep
improving from there, or is it still experimental?
-- 
Duy
