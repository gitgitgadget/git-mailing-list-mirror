From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 21:02:31 +0200
Message-ID: <201010042102.31336.j6t@kdbg.org>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com> <201010041802.57398.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brandon Casey <drafnel@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qJC-0000xo-W1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333Ab0JDTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:02:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:9566 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229Ab0JDTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:02:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ABF43A7EB5;
	Mon,  4 Oct 2010 21:02:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 927C919F609;
	Mon,  4 Oct 2010 21:02:31 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <201010041802.57398.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158095>

On Montag, 4. Oktober 2010, Robin Rosenberg wrote:
> Is anyone thinking "unicode" around here?

My recommendation these days is that you should not use git if you care about 
Unicode filenames: git is tied to POSIX in this regard, which defines 
filenames as streams of *bytes*.

-- Hannes
