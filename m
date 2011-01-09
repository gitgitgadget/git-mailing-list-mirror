From: tom fogal <tfogal@sci.utah.edu>
Subject: Re: manual http authorization (no netrc)
Date: Sun, 09 Jan 2011 12:49:13 -0700
Message-ID: <auto-000024264576@sci.utah.edu>
References: <auto-000024252997@sci.utah.edu>  <AANLkTik2QjOOoOcx0E7NeYEbs3YnLFPbG3x5J2RUFmRU@mail.gmail.com>
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 20:50:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc1HY-0007T9-Dw
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1AITuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 14:50:20 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:28835 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751564Ab1AITuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 14:50:19 -0500
Received: from dummy.name; Sun, 09 Jan 2011 12:50:17 -0700
In-Reply-To: Your message of "Mon, 10 Jan 2011 00:35:16 +0800."
             <AANLkTik2QjOOoOcx0E7NeYEbs3YnLFPbG3x5J2RUFmRU@mail.gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164860>

Tay Ray Chuan <rctay89@gmail.com> writes:
> On Fri, Jan 7, 2011 at 1:20 AM, tom fogal <tfogal@sci.utah.edu> wrote:
> > I'm getting authorization errors when I lack a .netrc for an
> > http-based server. Specifically:
> >
> > =A0tf@shigeru tmp $ git clone http://myhost:port/git/io.git
> > =A0Cloning into io...
> > =A0Username:
> > =A0Password:
> > =A0error: The requested URL returned error: 401 (curl_result =3D 22, http=
> > _code =3D
[snip]
> hmm, can you try passing username and password in this manner
> 
>   http://<user>:<pwd>@server:port/
> 
> ?

Yes.  That worked!  Though it was very quiet; the only message I
got was "Cloning into io..."; no "remote:" messages or "Receiving "
messages.  That's neither here nor there, though.

> Also, does your username/password contain special, non-alphanumeric
> characters? I remember there was a change to how we handled those
> some time ago.

Nope, both would encode fine in 7bit ascii.

Thanks much for the workaround,

-tom
