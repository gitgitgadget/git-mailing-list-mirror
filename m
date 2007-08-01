From: Yann Dirson <ydirson@altern.org>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 1 Aug 2007 20:50:42 +0200
Message-ID: <20070801185042.GB30277@nan92-1-81-57-214-146.fbx.proxad.net>
References: <86abtbnzpr.fsf@lola.quinscape.zz> <7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJIS-0002hJ-FI
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762214AbXHASvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761597AbXHASvr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:51:47 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:38071 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755312AbXHASvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 14:51:46 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 87EE07922;
	Wed,  1 Aug 2007 20:51:44 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5969A5A231;
	Wed,  1 Aug 2007 20:51:44 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 9A1101F070; Wed,  1 Aug 2007 20:50:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54464>

On Wed, Aug 01, 2007 at 10:12:13AM -0700, Junio C Hamano wrote:
> We recently normalized the script callers not to splice at all
> (the scripts were hand-rolling "the VISUAL or EDITOR or vi" and
> slightly differently).  It obviously has negative (i.e. setting
> EDITOR to "emacsclient --alternate-editor vi" does not work) as
> well as positive side (i.e. "/home/dak/My Programs/editor" would
> work).

And, indeed, --alternate-editor could be supplemented by another
envvar to be able to work in our situation.  Maybe the various emacsen
vendors would be willing to integrate such a patch ?

Best regards,
-- 
Yann
