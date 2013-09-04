From: Andriy Gapon <avg@FreeBSD.org>
Subject: Re: Bug in git rebase --continue in v1.8.4
Date: Wed, 04 Sep 2013 12:17:06 +0300
Message-ID: <5226FA92.5060709@FreeBSD.org>
References: <5221E661.1070200@gmx.de> <5226E8FC.8070208@FreeBSD.org> <vpqsixl9ezo.fsf@anie.imag.fr> <5226F4F8.7090304@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 04 11:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH9E4-0004d3-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 11:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762270Ab3IDJSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 05:18:08 -0400
Received: from citadel.icyb.net.ua ([212.40.38.140]:4197 "EHLO
	citadel.icyb.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762196Ab3IDJSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 05:18:07 -0400
Received: from porto.starpoint.kiev.ua (porto-e.starpoint.kiev.ua [212.40.38.100])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id MAA23526;
	Wed, 04 Sep 2013 12:18:03 +0300 (EEST)
	(envelope-from avg@FreeBSD.org)
Received: from localhost ([127.0.0.1])
	by porto.starpoint.kiev.ua with esmtp (Exim 4.34 (FreeBSD))
	id 1VH9Dv-0006SV-7O; Wed, 04 Sep 2013 12:18:03 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:17.0) Gecko/20130810 Thunderbird/17.0.8
In-Reply-To: <5226F4F8.7090304@FreeBSD.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233826>


This looks like bug in FreeBSD shell indeed.
If a script is sourced within a function scope, then 'return' in the script
causes the function to return.  But it should cause the sourced script to return.

I'll see what we can do about this.
Sorry for distracting you.
And thank you for the help!
-- 
Andriy Gapon
