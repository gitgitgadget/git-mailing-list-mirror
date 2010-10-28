From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 19:48:35 -0500
Message-ID: <20101028004835.GB31501@burratino>
References: <20101027131506.4da06c6d@MonteCarlo>
 <20101027223918.GA1877@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:48:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGfg-0007d5-3U
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab0J1Asn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 20:48:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65489 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab0J1Asm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 20:48:42 -0400
Received: by iwn10 with SMTP id 10so1673720iwn.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PWHnZQclyTKkkk2RdhIfWoWFQr6AdJsrZHNwuT25PvY=;
        b=FMxOlR5YF0Lna1YDG9ZsJBPsYT1MO2Iup1ulvK/UFuigcR+aWjJngYcPmcfFWcpg6K
         4cEj1+iYzo/1keisHgSddfjKRdtGcOGVIKE8HgPsSGpQh7REW45ny7kEdplv9KdBrjqv
         GkC5x4QuA9mOhf8dNBXctZ8UeHfKmrCJdJRuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WPK2Sx7N4dKjavUhrQhEokkvoQlU0cYLIaap2ee5spv+bIBBzDIArrLNO3Cu3Nsq67
         ZwQ3USumAD1kSJvGVTVOtuo2wwuBPE2naMalZ7x5N7irenbpvZSMeEqmFQe+JxAAPtj7
         TDY7Tk0FLM85JJJacd8CQAN1OkvpsH8bp16BY=
Received: by 10.42.191.16 with SMTP id dk16mr4274179icb.506.1288226921769;
        Wed, 27 Oct 2010 17:48:41 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 8sm924296iba.10.2010.10.27.17.48.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 17:48:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101027223918.GA1877@neumann>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160141>

SZEDER G=C3=A1bor wrote:

> I'm still puzzled that the only relevant entry I could find in the
> bash NEWS file is:
>=20
> i.  The programmable completion code now uses the same set of charact=
ers as
>     readline when breaking the command line into a list of words.

Here's a note to the Debian bash maintainer on that subject:

 http://bugs.debian.org/601632

I'm still too confused to come up with a documentation patch to send to
bug-bash.
