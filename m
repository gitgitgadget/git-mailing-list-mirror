From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-gui: apply color information from git diff
Date: Thu, 21 Oct 2010 13:59:44 -0700
Message-ID: <FB63A238-C5FD-4A00-9EAD-E99512C9D38B@sb.org>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com> <87hbgh7paf.fsf@fox.patthoyts.tk> <AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com> <87pqv4fqqz.fsf_-_@fox.patthoyts.tk> <7vy69stop2.fsf@alter.siamese.dyndns.org> <87eibje5zs.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Tor Arvid Lund <torarvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:59:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92Er-0003tj-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793Ab0JUU7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:59:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48586 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0JUU7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 16:59:48 -0400
Received: by pvg16 with SMTP id 16so24437pvg.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:59:48 -0700 (PDT)
Received: by 10.142.57.12 with SMTP id f12mr1341445wfa.229.1287694788394;
        Thu, 21 Oct 2010 13:59:48 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm3056601wfg.20.2010.10.21.13.59.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:59:47 -0700 (PDT)
In-Reply-To: <87eibje5zs.fsf_-_@fox.patthoyts.tk>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159570>

On Oct 21, 2010, at 8:22 AM, Pat Thoyts wrote:

> +	while {[regexp -indices -start $start "\033\\\[(\\d+)?m" $line match code]} {

Git currently doesn't emit combined escapes (e.g. \e[0;31m to reset and then turn on red text), but I can imagine it being enhanced to do this in the future. I would recommend handling it here if you can.

-Kevin Ballard