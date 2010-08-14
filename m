From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG RFC/PATCH] git-cvsimport
Date: Sat, 14 Aug 2010 16:09:28 -0500
Message-ID: <20100814210928.GC2372@burratino>
References: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:11:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkO0R-0008Dj-B4
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0HNVLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 17:11:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57096 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab0HNVLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 17:11:01 -0400
Received: by gwj17 with SMTP id 17so526261gwj.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e9GRqIO1R1Y7alIVNh6ZJJi3LyoP97NE5Z2NsB/aIAo=;
        b=esmTCT1+CBHQK8w+aWr4+JOlDVqMl84LQZjgTc0ws+hAcbFozpe0ZxgfHg9eY03Y5w
         v15T4JHaI0Z7W4PH7BI/1r7CHjUCAMWwKnOIl864o27CbBcz4a86Hym6yA8160g38Ohk
         8zlS1+JFcUwMTR4tiuHjwcMzQMe2uwgMx2cKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ecbTMh3xC+cOD905eCnlbCQfb61xdc9+wmd5UWM8KZzrfjc8TbqYdE7qzBwyOI0yWZ
         lBy2LCVf8fhxUMqJ+0HqvDChLuniN5mLKOOiPV4z/j+y2aAjIOpy0iD9fenkLQK9pVX2
         OzmhYOdKF1HhDL19EbMC2b3WUEXNwU8gaJwaU=
Received: by 10.150.197.14 with SMTP id u14mr3783831ybf.372.1281820260457;
        Sat, 14 Aug 2010 14:11:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q1sm4641147ybk.20.2010.08.14.14.10.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 14:10:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikxxqgNpmqfFQq+5GVd7VAW2DTaro5anRHcx6Tt@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153580>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> cvsps will just hang due to the unfriendly chmod.

Could this be fixed in cvsps[1]?

(Afterwards, it might still make sense to look into workarounds, of
course.)

[1] http://ydirson.free.fr/en/software/scm/cvsps.html
