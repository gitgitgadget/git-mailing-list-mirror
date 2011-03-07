From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Mon, 7 Mar 2011 13:48:46 -0800 (PST)
Message-ID: <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <m2r5aibpsl.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 23:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwixi-0004yF-SC
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 23:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab1CGWb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2011 17:31:29 -0500
Received: from mail-pw0-f56.google.com ([209.85.160.56]:47776 "EHLO
	mail-pw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab1CGWb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 17:31:29 -0500
X-Greylist: delayed 2562 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Mar 2011 17:31:29 EST
Received: by pwj9 with SMTP id 9so690909pwj.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 14:31:28 -0800 (PST)
Received: by 10.142.134.1 with SMTP id h1mr320617wfd.2.1299534526769; Mon, 07
 Mar 2011 13:48:46 -0800 (PST)
Received: by b13g2000prf.googlegroups.com with HTTP; Mon, 7 Mar 2011 13:48:46
 -0800 (PST)
In-Reply-To: <m2r5aibpsl.fsf@igel.home>
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13)
 Gecko/20101203 Firefox/3.6.13,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168614>

Sigh. You're right, what a silly man I am!!!

I assume there's no way to do what I want, except maybe encourage
everyone to use an alias for `git merge` that includes the flag.

Thanks, D.

On Mar 7, 3:10=A0pm, Andreas Schwab <sch...@linux-m68k.org> wrote:
> Dun Peal <dunpea...@gmail.com> writes:
> > There's a configuration feaute `branch.<name>.rebase` for specifyin=
g
> > that all merges into a branch (master in this case) would be done b=
y
> > rebase
>
> That's not what it means. =A0It means that a "git pull" is implicitly=
 "git
> pull --rebase". =A0But if you do an explict merge it will not look at=
 that
> config setting.
>
> Andreas.
>
> --
> Andreas Schwab, sch...@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
