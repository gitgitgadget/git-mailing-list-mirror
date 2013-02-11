From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 02:18:38 -0500
Message-ID: <CAE_TNim1eJpbpdYFVikk8e73i1oAmG+yqLK+tAomLoEm+ytzeQ@mail.gmail.com>
References: <7vfw13rd9x.fsf@alter.siamese.dyndns.org> <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin> <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:19:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nfe-0001Jj-1r
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab3BKHS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:18:59 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:50287 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3BKHS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:18:59 -0500
Received: by mail-qc0-f171.google.com with SMTP id d1so337905qca.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2pn3MqpyAjqgVVLi1Vhok+DuaRzTvGr52+5qel3wP1k=;
        b=bfhro6goOM48gJSY1T+wfVEe7A1RMc4BhqSJy3P18Bp8L+KDMgoLNVJFAllYnpaY+Q
         UcmRZKRTPmTxu9HL3Q3GeP1D3RGUDoZ84d9f3OFYdduxdxQFXMbkY4DUM/+RrafHjUWe
         oQvceEYExCel5H8fNeXZT8JtjMesvcvh6O/x2rGf2jPxkKCuIyKulk0879dXm1x5r/+y
         nMzJm29qzxyhg1K7/dCw5gQ2Hbyb4IEKn0kUq15UTahbI/LTd7Jp5Yy7oqLVG5Hp0zQs
         3mPa5LslXR4V7Iibakktqd/habHYEWa4QptAxs9fPawaNvuX0VtLE4PfCj+b+8VlGWcg
         3w0g==
X-Received: by 10.229.111.130 with SMTP id s2mr1213731qcp.91.1360567138341;
 Sun, 10 Feb 2013 23:18:58 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 23:18:38 -0800 (PST)
In-Reply-To: <20130211071235.GL15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216013>

On Mon, Feb 11, 2013 at 2:12 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Isn't that a criticism of the git-shell-commands facility in general?
> If it is common to have a lot of users with distinct home directories
> but all with git-shell as their login shell, then the
> git-shell-commands should not go in their home directory to begin
> with, no?

I know nothing of the security issues, but why not have a
/etc/git-shell-commands?

-- 
Ethan Reesor (Gmail)
