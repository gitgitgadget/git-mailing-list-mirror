From: Simon <josthi@gmail.com>
Subject: Git on tomcat via LDAP
Date: Sat, 6 Jun 2015 20:34:45 +0100
Message-ID: <DFA58178-5FB2-4C9D-91A6-5A2D1B3E0BE6@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 21:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Jru-0007LG-Bz
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 21:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbbFFTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 15:34:54 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35347 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbFFTex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2015 15:34:53 -0400
Received: by wiga1 with SMTP id a1so49582158wig.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:content-transfer-encoding:subject:from:message-id:date
         :to:mime-version;
        bh=PyVxgfTgQUuxH2wqP9lGQWPJbk38jUJ0QN6+mQa1dzM=;
        b=idLteiYnYtE/b61eU35GipfG2+lHmnCT03o7ypRHViMi57eIEVS2HwraTu1CpZGmKo
         l4J2TgaTS4plIaYN/25SbD6W92vxW3YFCqZutPvriJMC4/ovui9AG+C8CCWjB3306dEz
         MvK+ls2rLEYdQLPBsTKSwxEbTv4ooKN5l2bCnMpCEBz4pf02GZ0GMjpAfpXqDS+2wO0H
         4B1hOgKDMCme2bGAEaRoqs61202N0KnfIa5cYHGM8zD/7yvrA4sJShV6dMop+G6DWZUi
         4rb/aaoH2QN9c/m01RH502OtUG6q7mwhtjCSEgBZ4w3n4XE9+irg1iZJBkO+DBB3d41m
         OxBQ==
X-Received: by 10.194.79.73 with SMTP id h9mr17123961wjx.125.1433619291559;
        Sat, 06 Jun 2015 12:34:51 -0700 (PDT)
Received: from [192.168.0.3] ([90.206.104.103])
        by mx.google.com with ESMTPSA id ej5sm16428984wjd.22.2015.06.06.12.34.49
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jun 2015 12:34:50 -0700 (PDT)
X-Mailer: iPhone Mail (11D257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270940>


Hi All,

I am Simon working for VISA. I am new to Git and planning to migrate the projects from ClearCase.

Could anyone share the steps to configure git over http on Tomcat and enable the authentication through ldap to access the repositories?

Cheers,
Simon
Sent from my iPhone