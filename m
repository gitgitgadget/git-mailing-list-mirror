From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer
 conversion that violates alignment constraints
Date: Sun, 22 Jul 2012 23:51:48 -0500
Message-ID: <20120723045148.GA13623@burratino>
References: <20120722233547.GA1978@burratino>
 <7v8vebp0cl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAcn-0007MY-EB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab2GWEwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 00:52:00 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33059 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab2GWEv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 00:51:59 -0400
Received: by gglu4 with SMTP id u4so5077164ggl.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8ru5by+4zVxcD37XnHikKOO7VUQCLRvTtBqL0ynCF3g=;
        b=XdY7971U2MuCvdYQMVWwjpt/jkXT1KBVnlb+B7scb1S7R3Q1NIBeV00dMVc0w3nppJ
         S4rrq2uPozgsG1a1cN4ycFOFmv4k5mQQ8UDBKQsFVAGXS/rfLFM/SlBp8eFhKelUCTHm
         LOZYkLeDAoBbPFyhQiiE22cJmiFmYcRyWoRtoNwSe2IqvbV2zmeblsCL7CMf8jwmWGlv
         zDgmQTfhjhd1AGklsPK4AUHpEWalsV7Lx220JfxKVhGGKMdoH5jpH1KPxXSU58Md061A
         bENX27CarDZQ4mS9PqQLDLnMHFrFIo0qWNRsiyV1sH95DH10xL9wsMOSKlGG/5Rz32Lg
         miZA==
Received: by 10.50.188.233 with SMTP id gd9mr13441224igc.73.1343019118414;
        Sun, 22 Jul 2012 21:51:58 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id rd8sm11621773igb.3.2012.07.22.21.51.57
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 21:51:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vebp0cl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201896>

Junio C Hamano wrote:

> Thanks.
>
> Did somebody actually compiled Git for Alpha, and even more
> surprisingly on a big-endian variant of one?

Logs from building for Alpha and running the test suite are here:

 http://buildd.debian-ports.org/status/logs.php?pkg=git&arch=alpha

The big-endian part was just my idiocy, sorry.
