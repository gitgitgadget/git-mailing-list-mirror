From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Mon, 23 Jan 2006 21:05:09 -0800
Message-ID: <20060124050509.GD22848@kroah.com>
References: <20060120225336.GA29206@kroah.com> <7vlkxa30rd.fsf@assigned-by-dhcp.cox.net> <20060121001547.GA30712@kroah.com> <7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 06:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1GMs-0001Og-8y
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 06:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWAXFFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 00:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWAXFFR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 00:05:17 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28575
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964921AbWAXFFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 00:05:15 -0500
Received: from echidna.kroah.org ([192.168.0.10] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F1GMl-0000gy-SM; Mon, 23 Jan 2006 21:05:15 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15094>

On Fri, Jan 20, 2006 at 11:46:23PM -0800, Junio C Hamano wrote:
> The change introduced by 9e9b267 commit broke "correct" usage of
> git push to push matching refs, to work around a problem
> observed in a usage pattern on a shared repository.

<snip>

Thanks, I think this makes a bit more sense.

If nothing else, the documentation should be updated to reflect the
change in 9e9b267 :)

thanks,

greg k-h
