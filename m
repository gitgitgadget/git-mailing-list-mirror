From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 22:04:28 -0400
Message-ID: <32541b130809031904mb62d13du234da4558bead723@mail.gmail.com>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
	 <alpine.LNX.1.10.0809031907540.12887@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Boyd Lynn Gerber" <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb4IX-0004Nw-It
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 04:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYIDCEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 22:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYIDCEd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 22:04:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:59855 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbYIDCEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 22:04:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3040970rvb.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zJngVX//6wTr3kEfzb/w9SZFw0/ib7l5ZIdaENDshfk=;
        b=kHT6NN4LgFTDJSbbWbLRKRYplwGjKiMds4ntG49b3tyU0L3UKVxR/QuJDlDo5s5zdv
         2F/asC7l8Qj3OqJbgAnScK/oks/4C9r/q0bvdmNW5maG6/Aj2QhgiSFoZt6XmMQzRM3F
         dnn73s5cg5ZC9AoER0aUz3dD5h/FSQUxXGai8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P8OHK2KzCdz81ZzJlcUtHgeQwPcIgZ3T5HDwDuabT/2fHHGlZUBBv3j19qMyVRexF9
         MVfNEZJDw4qC2NPwHqu7kPTT/Hk9+WeyUrpFOMT82PB62Hl6LjQTmlRqPngJTY8kU4am
         7dYiwjeKKTVJCdqo0HoBXEFOmp2u/Ft34XY7I=
Received: by 10.141.75.17 with SMTP id c17mr5324450rvl.212.1220493868129;
        Wed, 03 Sep 2008 19:04:28 -0700 (PDT)
Received: by 10.141.194.15 with HTTP; Wed, 3 Sep 2008 19:04:28 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0809031907540.12887@suse104.zenez.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94878>

On Wed, Sep 3, 2008 at 9:10 PM, Boyd Lynn Gerber <gerberb@zenez.com> wrote:
> I really hate getting everything working only to then have another break-age
> from master on a pull.  Can we please try to keep some compatitbility with
> other non linux OS's.

Well, it's kind of unavoidable; presumably most of the developers
don't have access to a UnixWare system, and thus have no idea if their
patches will break compatibility with it.

Perhaps what you need is an autobuilder running on UnixWare that will
build Junio's pu and next branches, so that you can report problems
before they make it all the way into master.

Hey, what a coincidence!  I have just what you need! :)
http://marc.info/?l=git&m=122015205123247&w=2

Have fun,

Avery
