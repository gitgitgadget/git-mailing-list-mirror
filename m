From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: Re: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 01:47:34 +0100
Organization: www.grml.org
Message-ID: <fs9i36$qck$1@ger.gmane.org>
References: <fs9f0o$jge$1@ger.gmane.org> <Pine.LNX.4.64.0803242359230.24262@kaos.quantumfyre.co.uk> <7v1w5zslv5.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 01:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdxL6-0001me-QR
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 01:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbYCYArv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 20:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYCYArv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 20:47:51 -0400
Received: from main.gmane.org ([80.91.229.2]:50974 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbYCYAru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 20:47:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JdxKK-00027z-Da
	for git@vger.kernel.org; Tue, 25 Mar 2008 00:47:44 +0000
Received: from 84.119.6.6 ([84.119.6.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 00:47:44 +0000
Received: from gebi by 84.119.6.6 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 00:47:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.119.6.6
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78136>

* Junio C Hamano <gitster@pobox.com> wrote:
> Julian Phillips <julian@quantumfyre.co.uk> writes:
>> On Tue, 25 Mar 2008, Michael Gebetsroither wrote:

>>> % git-add -f foo/.git/bar
>>> fatal: unable to add foo/.git/bar to index

> Also it is false that we should only care about the first one.  Think
> submodules.

Would it be possible to allow it with git-add -f or does that break to
many cases?

cu,
michael
-- 
It's already too late!
