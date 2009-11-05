From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare 
	repos
Date: Thu, 5 Nov 2009 06:54:12 +0530
Message-ID: <2e24e5b90911041724u67a23278t6c0fc86a8ecc7d51@mail.gmail.com>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	 <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
	 <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
	 <20091104235241.GA12984@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 05 02:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5r5I-0004UD-19
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbZKEBYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 20:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758383AbZKEBYI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:24:08 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:56033 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380AbZKEBYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 20:24:08 -0500
Received: by iwn10 with SMTP id 10so5439552iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q44voZhTfjKxFnk96zkb6n5KImAnfbvTLx3SSJIRwTM=;
        b=D5puHDOFqqpV6+/UrxmNM6IVn/HOhggGRAFT5Xf0P/pi7EtLeMOF4ifarLJg4oOCmo
         X9tP08Y1QOvnrV/4W5Z0tYI66xOZGsLAt8cUetb5x+HN1psdd31R+ZIrguhIGAMkV6Q4
         o/2jgwJXQ2umLAfdhV4SGprqfzqJcAuMy4LqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hl4asOZT4vxAsJ1MyhKU+knLMR31fs0+6mkeRi16nIDF5OehcgenHXZYvb5ZGBnBr3
         iz7oLo56ohyAVPZYxFc1+OiqjqF6IF+d4X4U3Av6wlJOjx2v6Ywtg6t0kkaURERVhQs6
         gKXHROtY90hoaDz+2gBA0VIDTclsrpTJpVATM=
Received: by 10.231.124.227 with SMTP id v35mr852788ibr.18.1257384252422; Wed, 
	04 Nov 2009 17:24:12 -0800 (PST)
In-Reply-To: <20091104235241.GA12984@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132185>

On Thu, Nov 5, 2009 at 5:22 AM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>=
 wrote:
> The 04/11/09, Sitaram Chamarty wrote:
>
>> But if you are able to do "gc" manually on any repo you can also do
>> "reflog expire" before "gc" can you not? =C2=A0Please correct me if =
I'm
>> wrong.
>
> "If we are able to do 'gc' on any repo"... But a lot of users aren't
> able to it because they aren't the admin.
>
> Or did you mean if "non-admin users could" ?

dscho's original mail said: > With gitweb on a public site, there
might be a problem when you pushed
> some blob containing trade secrets accidentally, and try to scrub the
> repository using "git gc" after a forced push.

That's a manual gc.  If you can do a manual gc, you can do a reflog
expire before the gc, is what I meant.

>
> --
> Nicolas Sebrecht
>
