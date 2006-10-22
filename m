From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/2] Make "stg mail" behave better with non-ascii characters
Date: Sun, 22 Oct 2006 14:45:51 +0200
Message-ID: <20061022124551.14051.25145.stgit@localhost>
References: <20061022121240.GA21084@diana.vm.bytemark.co.uk>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:49:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbclg-0007f0-4V
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWJVMt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJVMt3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:49:29 -0400
Received: from mxfep04.bredband.com ([195.54.107.79]:59801 "EHLO
	mxfep04.bredband.com") by vger.kernel.org with ESMTP
	id S1750779AbWJVMt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:49:28 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep04.bredband.com with ESMTP
          id <20061022124927.QTLB8360.mxfep04.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:49:27 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 14:49:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id BB9644C010;
	Sun, 22 Oct 2006 14:49:26 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022121240.GA21084@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29726>

These two patches teach "stg mail" to ref2047-escape non-ascii
characters in the mail headers (not doing so is illegal), and
QP-encodes the body (leaving it as 8bit is not well received by some
mail severs, notably vger).

The first patch is a resend, this time hopefully with my name intact.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
