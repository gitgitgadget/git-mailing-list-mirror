From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Determine Blob ID from Commit ID and File Path
Date: Thu, 25 Jun 2009 12:07:45 -0700
Message-ID: <7vhby49loe.fsf@alter.siamese.dyndns.org>
References: <C66917DD.29BF%dirk.sigurdson@t-mobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Sigurdson\, Dirk" <Dirk.Sigurdson@T-Mobile.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuIb-0003zX-Tz
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbZFYTHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbZFYTHn
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:07:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36360 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZFYTHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 15:07:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625190746.WNXC25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 25 Jun 2009 15:07:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8K7l1c00W4aMwMQ04K7lb6; Thu, 25 Jun 2009 15:07:46 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=PqrRdNMCve8A:10 a=dbcnAWtwAAAA:8
 a=Aw5wmsSLa6zJ3nilXfMA:9 a=9abpK5L-qWM3vgg0qBVSJSKVqmcA:4 a=FDGbELqaNmEA:10
X-CM-Score: 0.00
In-Reply-To: <C66917DD.29BF%dirk.sigurdson@t-mobile.com> (Dirk Sigurdson's message of "Thu\, 25 Jun 2009 12\:02\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122237>

"Sigurdson, Dirk" <Dirk.Sigurdson@T-Mobile.com> writes:

> Given a commit id and the path to a file, I=C2=B9d like to be able to=
 determine
> the blob id for the file.  Is there a git command that would provide =
this
> info?

"git rev-parse $commit:$path"?
