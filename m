From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bash: support pretty format aliases
Date: Sun, 10 Oct 2010 16:44:11 -0500
Message-ID: <20101010214410.GA16253@burratino>
References: <1286746461-7338-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53jw-00067F-Es
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab0JJVr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:47:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61144 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJVr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 17:47:26 -0400
Received: by iwn6 with SMTP id 6so2586652iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nr2soHqX54Wa3sbqExTcXiF4ruVW8SGpzhX9C8nh26M=;
        b=rklz/WTxsTrJrN/22EH7p/LKw58ts6UtJmMN0rFSL/B3KjcwjrBjFm6W0gwr2CjhcS
         zhP3HoHMWSh8RigE1aOt6BYztj1N9m5QaTXB3N48gv7pa/94Z0WRfL7gffDWjS6lLvvs
         xXYVktts0Gld+iy22q9w7DJAnNt8vWvnWdKD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xwLI5qomGFZ+EwBulAhhhzIKNce58oJRq+4Lgzlvp35ZAtHrziumZe4SueI/LzsaxY
         lyOWoVDitLqwyzvprpACm36Dn9qL3I3HCvUEFoHKKWF2pbQ6YwTjQ7ieika6bKmOCO0J
         /4DjzafWqOKcg4R412QXe3bTjbyRC1Li4oIxE=
Received: by 10.42.137.4 with SMTP id w4mr1367406ict.298.1286747245235;
        Sun, 10 Oct 2010 14:47:25 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x10sm6438187iba.4.2010.10.10.14.47.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 14:47:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286746461-7338-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158717>

SZEDER G=C3=A1bor wrote:

> Users can have their own pretty format aliases since 8028184 (pretty:
> add aliases for pretty formats, 2010-05-02), so let's offer those
> after '--pretty=3D', too.
>=20
> Similar to the completion of aliases, this will invoke 'git config'
> each time pretty aliases needs to be completed, so changes in pretty.=
*
> configuration will be reflected immediately.

Does this apply to

	git log --format=3D
	git show --pretty=3D
	git show --format=3D

too?
