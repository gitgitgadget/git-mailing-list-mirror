From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 12 Jan 2016 09:06:12 +0900
Message-ID: <20160112000612.GA32363@glandium.org>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 01:06:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aImTg-0005fi-De
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 01:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762084AbcALAGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 19:06:20 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38036 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762081AbcALAGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 19:06:20 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aImTV-0000xL-0A; Tue, 12 Jan 2016 09:06:13 +0900
Content-Disposition: inline
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283737>

On Mon, Jan 11, 2016 at 03:45:35PM -0800, Junio C Hamano wrote:
> * mh/notes-allow-reading-treeish (2015-10-08) 3 commits
>   (merged to 'next' on 2015-10-23 at 8a697f0)
>  + notes: allow treeish expressions as notes ref
>  + Merge branch 'jk/notes-dwim-doc' into next
>  + Merge branch 'jc/merge-drop-old-syntax' into next
>  (this branch uses jc/merge-drop-old-syntax.)
> 
>  Some "git notes" operations, e.g. "git log --notes=<note>", should
>  be able to read notes from any tree-ish that is shaped like a notes
>  tree, but the notes infrastructure required that the argument must
>  be a ref under refs/notes/.  Loosen it to require a valid ref only
>  when the operation would update the notes (in which case we must
>  have a place to store the updated notes tree, iow, a ref).
> 
>  As the patch was done on top of the 'drop old-syntax from merge',
>  this has to wait until that other topic can graduate, unfortunately.
>  It can be redone in a way that does not depend on that topic after
>  this cycle, though.

I'm not sure what you mean here. The patch applies just fine on top of
current master.

Mike
