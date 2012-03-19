From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git push default behaviour?
Date: Mon, 19 Mar 2012 17:12:21 +0100
Message-ID: <CAGK7Mr7Wf4S-OaWiQY3vWxKzhSV6nu76kVsWMbC_8GFghrfaJw@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch> <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk> <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk> <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
 <buoy5qxi0vx.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremy Morton <jeremy@configit.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fCq-0002a7-PA
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655Ab2CSQMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 12:12:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55937 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229Ab2CSQMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 12:12:51 -0400
Received: by iagz16 with SMTP id z16so9629969iag.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QcVx3XLxQtuXJoyTq0IUiBVZg5nnmlywy6o0DUeK8Wo=;
        b=brFq2E+MdhZTfYAnI/ABBM8Sco2dJ0DR6sBmZRBtMXmDtEiJfNg6amzM+e5YnDL3nv
         KDOEYu5CT3WBI8aOXoqQ2cR/0yo6w0FO80GgfdsHbzj05BgecbUn6ScWtUeDG9YkAQ+H
         wxlAkJPLZNynRWgtW4fGim7domQz7Khi+HsaWYSAbugyel5nqYtf/uAWzcxnDJMZryE0
         4y8V2IHRjhOIQBWvxxOb5Pzi6MgAH5p4n4LcbVIrKQOPNsLVJmC4I68ki5BWoewZU4Jo
         9ZJMQRI+pt0TocDkg9emxKR+HNUarA11BzoofL5Qv9C7mbmVWCNxKqlxLm67GeDHu8p/
         Jp5Q==
Received: by 10.50.45.130 with SMTP id n2mr6500057igm.45.1332173571228; Mon,
 19 Mar 2012 09:12:51 -0700 (PDT)
Received: by 10.50.106.170 with HTTP; Mon, 19 Mar 2012 09:12:21 -0700 (PDT)
In-Reply-To: <buoy5qxi0vx.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193434>

=46WIW I also think we'd change the default to "upstream".=A0The proble=
m
with this default is that most repos only have one branch (master) and
thus they never run into this problem, so most people don't get the
habit to modify push.default AND they get the (bad) habit of typing
"git push". Then they work with multiple branches and get unexpected
pushes (with or without --force, especially when sausage making).

I know it's "their" fault for not learning more about git push's
defaults, but the current default is clearly against the principle of
least surprise IMHO.

Philippe
