From: Teemu Likonen <tlikonen@iki.fi>
Subject: "git help stage" doesn't display git-stage man page
Date: Wed, 03 Dec 2008 09:27:17 +0200
Message-ID: <87myfdn2ga.fsf@iki.fi>
References: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 08:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7mA3-0006t4-Hr
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 08:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbYLCH1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 02:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbYLCH1X
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 02:27:23 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34076 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbYLCH1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 02:27:22 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8901FE6147; Wed, 3 Dec 2008 09:27:19 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1L7m8j-0001Lg-M4; Wed, 03 Dec 2008 09:27:17 +0200
In-Reply-To: <7vvdu1hj41.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 02 Dec 2008 22\:23\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102220>

Junio C Hamano (2008-12-02 22:23 -0800) wrote:

> * The 'master' branch has these since the last announcement
>   in addition to the above.

> Scott Chacon (1):
>   Add a built-in alias for 'stage' to the 'add' command

I think there's a minor user-interface defect:

    $ git help stage
    No manual entry for gitstage

"git stage" is only a built-in alias but at some point it may become the
primary staging command for new Git users and hence a kind of real Git
command. I think "git help stage" should show the git-stage manual page
(even though it only points to git-add(1)).
