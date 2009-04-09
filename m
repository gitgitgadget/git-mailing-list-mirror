From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git diff after merge (with conflict)
Date: Thu, 09 Apr 2009 20:40:51 +0300
Message-ID: <87ljq97mjg.fsf@iki.fi>
References: <324.1239298063@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:43:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryGx-00077A-B6
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbZDIRlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756691AbZDIRlI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:41:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43892 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbZDIRlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:41:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 49CA1EE500AD291C; Thu, 9 Apr 2009 20:40:56 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LryF9-0001vH-GL; Thu, 09 Apr 2009 20:40:51 +0300
In-Reply-To: <324.1239298063@relay.known.net> (layer@known.net's message of "Thu\, 09 Apr 2009 10\:27\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116188>

On 2009-04-09 10:27 (-0700), layer wrote:

> Is there some way to get regular unified diff behavior instead of the
> combined diff? For certain files (like ChangeLog's) the combined diff
> format after a merge is *very* confusing.

Maybe the following commands are helpful:

    git diff --base
    git diff --ours
    git diff --theirs

Those options are not documented in git-diff(1), by the way.
