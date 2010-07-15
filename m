From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Add SVN dump parser
Date: Thu, 15 Jul 2010 15:04:37 -0500
Message-ID: <20100715200437.GF2774@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-9-git-send-email-artagnon@gmail.com>
 <20100715195206.GE2774@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 22:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZUgf-00040v-As
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 22:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934632Ab0GOUFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 16:05:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47731 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934613Ab0GOUFe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 16:05:34 -0400
Received: by eya25 with SMTP id 25so277421eya.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wNKls+5xEqByFrTD5jTcYTVxd96KrE5ZkSypeE44Awo=;
        b=j0ztjGDW1FxSiajeN3RGvkpzbOrQHtkK5HDU7tQVofVeFVZ79NDWd+5R1iQczMJYqF
         1jmRUGEF1XO9P4Xq3x5vUQHkDtar+AhaVwI9wvO6mfGgklGCn7RESrkCO08gSqdj8fYY
         twtEUbuM0eCeXLrvinEKX9xIOGa0IuZ+hx4uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wGEluDib413uRRNVTHGu5CdDoJgCd+WW0dfgKa0Pp4wgo+rfbJwggIOTasTKV+9Dwz
         RaDqiTDlzQ5z8RziZfRfp603BJ5PknMqbZpEZwWD2pQKLnenlPsyb0zA/FSbrIF8uRA2
         BI1TalnE8VaMjWuV8+pntKkXsic+w+GvnCRtg=
Received: by 10.213.4.146 with SMTP id 18mr226538ebr.11.1279224329444;
        Thu, 15 Jul 2010 13:05:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id z55sm10976876eeh.3.2010.07.15.13.05.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 13:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715195206.GE2774@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151119>

Jonathan Nieder wrote:

> I don=E2=80=99t think anything I did
> comment on should prevent this reaching a wider audience.

Except for the obj_pool persistence bit, but you already commented on
that.

Happy travels,
Jonathan
