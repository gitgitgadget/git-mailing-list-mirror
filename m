From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 1/2 v2] Add a basic idea section for git-blame.
Date: Sun, 11 Apr 2010 10:23:25 +0800
Message-ID: <y2l41f08ee11004101923j90709b65mee7c3defb6511246@mail.gmail.com>
References: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
	 <1270894530-6486-2-git-send-email-struggleyb.nku@gmail.com>
	 <7veiinw0bw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 04:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0mps-0005kU-4n
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 04:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab0DKCX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 22:23:27 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33108 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0DKCX0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 22:23:26 -0400
Received: by qyk9 with SMTP id 9so2733626qyk.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A7ei5hI1Nv+URYql0zwhBIf2fdMzdRYZpBd7tJgEdI4=;
        b=FiI33xuyWFW9OvtdhAe6dj1eJCqJx/oFkdCV14iVA/Mm1t0f0yRUK56Ca6J5jdLopK
         kqLqeCjCkOtUH+8jka780g3Zs4r5C3ACe7R3ol3wlFJMVJc0/+yNeFjrrOAvQFFhDz8l
         gcyloQoTXNDyjt7bTirmfjVjB79JZHGZ+GWv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YnJYJjdehOVnjdPtvMz1RXJZZGefI1cTR0T3zRfxXXb8bEHjyzca35zp8/JzDlnsYS
         RlsfMHn2vS/p6pnhFv9PKw5PmSxAWZFuuE5C+i+MQb51ZsW3gM89QWCg6TPWNY0cDFzy
         9afxHNp3nKEX4drp0YFAvCILW8yfgavqwnmbg=
Received: by 10.229.95.147 with HTTP; Sat, 10 Apr 2010 19:23:25 -0700 (PDT)
In-Reply-To: <7veiinw0bw.fsf@alter.siamese.dyndns.org>
Received: by 10.224.110.2 with SMTP id l2mr793283qap.164.1270952605401; Sat, 
	10 Apr 2010 19:23:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144625>

Hi Junio,

On Sun, Apr 11, 2010 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It doesn't really matter to them _why_ only B is blamed to the parent=
 in
> "A B" -> "B A" movement without -M (and your "BASIC IDEA" section is =
too
> sketchy for readers to guess why, even if they wanted to learn the
> implementation detail, which they typically don't).
>
> Things like:
>
> =A0 =A0- they can use -M to annotate across block-of-lines swappage w=
ithin a file;
> =A0 =A0- use of -M adds cost --- it spends extra cycles;
> =A0 =A0- similarly -C annotates across block-of-lines swappage betwee=
n files;
> =A0 =A0- use -f -C adds larger cost; ...
>
> are the only important things they want to know about, no?

I think all the four things above are mentioned in [PATCH 2/2 v2]
message, it contains who should the command pass blame to and the
order of the algorithm used. Would you please take a look at that
patch?

And the BASIC IDEA section just want to make a basic description about
how blame works briefly. If you thought that it is non-use for
end-users, how about just discard it and make a more technical one at
technical/git-blame.txt ?
Thanks!

Regards!
Bo
