From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Relicensing test_set_editor
Date: Mon, 26 Apr 2010 00:08:20 -0500
Message-ID: <20100426050820.GA30942@progeny.tock>
References: <87vdbi37yp.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 07:07:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6GXp-0005cu-5l
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 07:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab0DZFHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 01:07:39 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51121 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0DZFHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 01:07:39 -0400
Received: by qyk9 with SMTP id 9so16768932qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ce2ML0Ht++wJxQMKUX6/QBGOV4mn8s8sPntjUuUsJes=;
        b=RPIIkEzuceQLT2fsU9y5id6sJUUjO7j77nP3IXZga8kO2Vy0ffPxE7sJybhAeUwYGB
         rPl4VjwVj1TS0qHXQeMYKU+OFBbDGEnlEywlCB+f8e3E3WPTPL4w5dI4jn8xEJCdgyLF
         +r251fsG55dYT2vhAqb7+yQK/CRRxia3sC05Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kYr1HllJIBxOswEemHRdGC43CD3hC97pGxMKeIxj35Jv4jkD+5eTqaMlz0SCeA//RD
         P8j1m3XOIPUMUIp6aR5q5f1CVXS3cC1GB+uv6wzbUqZEOZnYX7Wue7LzM+8QwUvwOP1E
         O+BLOZyyqaJVZcz1lHredixtWErfb0aRfVkTI=
Received: by 10.229.239.149 with SMTP id kw21mr4077922qcb.99.1272258457290;
        Sun, 25 Apr 2010 22:07:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2820613iwn.12.2010.04.25.22.07.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 22:07:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87vdbi37yp.fsf@steelpick.2x.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145789>

Hi Bryan,

I was wondering: would you be okay with relicensing your test_set_edito=
r()
function from git=E2=80=99s test harness as GPL-2+?

The functionality is useful, so if that is not okay, I guess someone
who hasn=E2=80=99t read the code would have to reimplement it[1].  I th=
ought I
should ask because clearly you have not disappeared from the face of
the planet. :)

Thanks for your work, and sorry for the bother,
Jonathan

[1] Context: the Notmuch mail project would like to use git=E2=80=99s t=
est
harness.  The ack-collection for a patch to change the license to
help with uses like this is being tracked here:

https://git.wiki.kernel.org/index.php/Test-lib_reclicensing
