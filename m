From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: git commit -C vs. prepare-commit-msg hook
Date: Tue, 2 Nov 2010 15:50:59 +0100
Message-ID: <20101102145059.GB2116@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 15:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIDa-0000LS-AU
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 15:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0KBOwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 10:52:04 -0400
Received: from [141.21.7.5] ([141.21.7.5]:19454 "EHLO exchange.fzi.de"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751504Ab0KBOwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 10:52:01 -0400
Received: from localhost6.localdomain6 ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 2 Nov 2010 15:50:59 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 02 Nov 2010 14:50:59.0923 (UTC) FILETIME=[5D04A230:01CB7A9D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160524>

Hi,

Just noticed (read: got bitten by ;) that 'git commit' runs the
prepare-commit-msg hook even if it was invoked with the -C option.
This seems contradictory to me, because 'git commit -C' is to reuse an
already existing log message (and author info) as is, whereas
prepare-commit-msg is there to automatically edit the commit message.

Is this desired and I'm missing something, or is this a bug?  (or just
accidental, but we can't do anything about it anyway because of
backward compatibility?)

Thanks.


Best,
G=E1bor
