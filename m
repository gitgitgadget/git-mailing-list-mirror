From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/10] Use 'remote-tracking branch' in generated merge
 messages
Date: Sat, 23 Oct 2010 14:04:41 -0500
Message-ID: <20101023190441.GK21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-9-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:09:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jSf-0007We-Sz
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab0JWTIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:08:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51564 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667Ab0JWTIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:08:32 -0400
Received: by ywk9 with SMTP id 9so1420529ywk.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ghntEv5UbsjdT8OOmXSKRu8AZz3Ln2tRFsaKhU5d/lc=;
        b=lMqyp3Mr9cGn+iXNWmS+TyuuZo1foQ7yJZiq+nPq7MRb9t1LM24Cmbfm4AB+wpre1q
         19cawK7/dj0vqqS78wbCNOJA6GUE7Lo8Maa/FpxmHtfChWi3umhlzpMYB9q5RiWtRrpL
         JR8qEtOtSFzrOJNz/n4hwKfGWrN1ZvUfIpoJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G3TK2V74QmnP727V+zoCtwif8Q2Jr00M12sfLEKVQjHZQzZZhYxLgiqpfXo50elHTk
         g8jI+lAKFdqMUpx4eRuReGW67eHhldNUqeysETOXSpr8Z7MTWfN58IGlGxpq5gVfIh1I
         GneTYC5CojyfVqPs9SV3ZZ1JhtUkIqOa3/YwM=
Received: by 10.151.44.18 with SMTP id w18mr456511ybj.255.1287860911572;
        Sat, 23 Oct 2010 12:08:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z33sm3696340yhc.33.2010.10.23.12.08.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 12:08:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-9-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159818>

Matthieu Moy wrote:

> [Subject: [PATCH 08/10] Use 'remote-tracking branch' in generated merge messages]

Maybe this should be squashed with the corresponding "git fetch" hunk
in 7/10 for bisectability.
