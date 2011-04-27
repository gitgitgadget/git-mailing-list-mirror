From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 08:47:48 +1000
Message-ID: <BANLkTinxFNSXEnRR0ZACO0W-+kDL0CD-qg@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<BANLkTimsWmtXzogjN4bPkhmV8K=y1c4AmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDWW-0004bm-3L
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097Ab1D0Wrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 18:47:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44320 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1D0Wru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 18:47:50 -0400
Received: by ewy4 with SMTP id 4so660238ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B21pzjjWovQ5Ui9meNXD46HHJNsr2IIS7g6/kmwmniY=;
        b=EH0N6Is0KiHovucS5pE6LyQh5P8FxFeG90hINc/xrdxwFPTX61VX2VVrMoEKsgq3/U
         2WYBTkdst995XiCnzjlGBA6kSi7NObuZi/4QW2PgsjxLsYEvM+wjP4oS7EnVWj0oTEPx
         947Q+8qLoL0CyzaT/CN4xEH8w2bUlXYna7fDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RyXHRPpZzrB8yQhJ1sVXTfewCUi7DhWJLjyfIiinRRprdAk4KufZsB2PiZe9SIqxMf
         gKQsDPtBym5Enkpa1wkzjtLhl9V0d8CjaNyEnAFLL+g60ca8Wt8J+8jHO8ZaPDnUkMV+
         hsOcVi30utn3yOxdFVQ/BdK+/BTrTtTLYa9SM=
Received: by 10.14.7.1 with SMTP id 1mr1182399eeo.245.1303944469000; Wed, 27
 Apr 2011 15:47:49 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 15:47:48 -0700 (PDT)
In-Reply-To: <BANLkTimsWmtXzogjN4bPkhmV8K=y1c4AmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172284>

On Thu, Apr 28, 2011 at 8:32 AM, Pau Garcia i Quiles
<pgquiles@elpauer.org> wrote:
> Hi,
>
> Can we please split this debate into the two threads that have arisen?
>
> a) git extensions (the original point)
>
> b) git package manager
>
>
> Let me give my unrequested opinion:
>
> a) I like it. Mercurial has it. It requires more or less what Jon says
> below: let's define a hierarchy of where to place the executables,
> documentation, the extenions' porcelain (which IMHO would require one
> directory per extension), etc
>


> b) Please no. As a Debian developer, I'd rather see extensions
> distributed as source, then I would package them. It's what Debian
> (and other distributions) are doing now with Ruby gems, Python eggs,
> etc: we provide packages for them so that you do not use gem, etc
>

I absolutely agree that is the right approach. To the extent that my
proposal supports:

    git pm install foobar

it would do so by delegation to package-manager adapters (in effect
acting as a meta package manager).

However, I don't want to further distract discussion by having a
debate about whether a meta package
manager is a good idea or not.  So let's concentrate on what:

   git pm activate

would look like and do.

jon.
