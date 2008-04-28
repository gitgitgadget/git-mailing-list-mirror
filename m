From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 13:26:19 -0400
Message-ID: <32541b130804281026n31dae2a3w30cd9c98a9a88e0a@mail.gmail.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
	 <20080427064250.GA5455@sigill.intra.peff.net>
	 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
	 <slrng1be8l.25r.joerg@alea.gnuu.de>
	 <86k5iib0g9.fsf@blue.stonehenge.com>
	 <slrng1bqhb.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 19:27:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqX8D-0007Nr-JG
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbYD1R0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 13:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765697AbYD1R0Z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:26:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:57066 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765334AbYD1R0Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 13:26:24 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5882128fkr.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C8KLNDAw0z9ZHBNjNK5LDF8DdkVW96KcCEFwRmZckic=;
        b=VWiVVwgRBMjbu1Lr/AEYxb1bHLGHrAyP5xopmUnh+/jwj8EPbJevEYsltz39FI/+mckwvvjlCuVEUO4bKgN3Uw47GWrXHLPD63m5sMoYR5KgoV3Ima8Tk9L68mGNImERfaAH6GI8r4aN2byM5kjBqzkRZ3AfsN2PdmTGJsmfZDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jba2FFttBMAPtqWEhah+wusSH78gQ7dqOMCpqwkxXfYmLg/HcA/j4Y/Ds4NrYJDtu6jXfUlDU0EfeYaUD5u4ed3G6ItBc84frU/L0GPzB0SXZQDbRUO5aQpMKlH+3ZOvrQ+JkSrc8ehdbUVsfmbW2vn75YCQ+sZzwN6uBzKMkOY=
Received: by 10.82.115.8 with SMTP id n8mr3741927buc.21.1209403579289;
        Mon, 28 Apr 2008 10:26:19 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 28 Apr 2008 10:26:19 -0700 (PDT)
In-Reply-To: <slrng1bqhb.25r.joerg@alea.gnuu.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80567>

On 4/28/08, J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
>  And what about something like this: 'tac || rev || perl =85'

Or we could just add a git-tac.c and use that :)

Have fun,

Avery
