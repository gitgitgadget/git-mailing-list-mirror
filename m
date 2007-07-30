From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] per-user ignore file
Date: Mon, 30 Jul 2007 16:36:05 -0400
Message-ID: <20070730203605.GD2386@fieldses.org>
References: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFbyO-00088E-7S
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 22:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966655AbXG3UgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbXG3UgI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 16:36:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33792 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966655AbXG3UgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 16:36:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IFbyH-00060U-Ap; Mon, 30 Jul 2007 16:36:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707301612160.8054@iabervon.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54261>

On Mon, Jul 30, 2007 at 04:28:13PM -0400, Daniel Barkalow wrote:
> It would be nice to have a per-user ignore file, so that emacs users can 
> ignore "*~", "#*#", and ".#*". Probably this should be in the form of 
> having a config option for additional ignore file names, so that the user 
> can decide where to put it. (E.g., ~/.gitignore would be an issue if the 
> user is tracking their home directory with git and wants to ignore some 
> files in the home directory repository but track similarly named files in 
> some other repository). Are there any fundamental issues with this, or is 
> it just that nobody's been sufficiently motivated to do it?

See 'man gitignore' or

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#ignoring-files

--b.
