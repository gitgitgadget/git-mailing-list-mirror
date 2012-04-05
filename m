From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 05 Apr 2012 16:18:53 +0000
Message-ID: <1333642733-ner-3749@calvin>
References: <11292500.AVmZFUUvNi@flobuntu>
	<CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
	<2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio>
	<20120402205659.GA13725@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner@student.tugraz.at>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:19:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFpPE-0002BV-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab2DEQTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 12:19:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36269 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab2DEQTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 12:19:20 -0400
Received: by wgbdr13 with SMTP id dr13so1480494wgb.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=vGPFBJncSw5dXIjsIuQzKaYaMUn5TIscdRB4BNQuYmo=;
        b=VMT5fQxDKkqRzGtqIMJWrWSIBkJ+VAhxTrTjUoq7CZb7bEVJBxzCDopwl3ghCm35UF
         Qub2pvf6QIiNtwzNND7uDm3yrw4LNrBMc/AxHEiPM3f63BjtUnPL+q1XlA8UXUhzHCis
         Nw2SXsNf6pHa5NGbTXOwn3F3/QQnysKtfT42BVnWS6R7O0Efci6o84t8U8dnPcPyLyEp
         CQVUXLv7pN4LsLhqK6lxjsCYV6vVOXplww2oS9gndceJ7OXUThMcTWMuwLEhe0dRV236
         pVSmUMyMtSG4JJAegx37rriAMqbVuH+02kGp8lV1wNRuiFGTs2suCvi1wKbrk3i5bgqH
         QPYw==
Received: by 10.180.73.143 with SMTP id l15mr6206477wiv.11.1333642758706;
        Thu, 05 Apr 2012 09:19:18 -0700 (PDT)
Received: from calvin.caurea.org (62-2-168-230.static.cablecom.ch. [62.2.168.230])
        by mx.google.com with ESMTPS id fz9sm14750064wib.3.2012.04.05.09.19.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 09:19:18 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 2ABEA194D53; Thu,  5 Apr 2012 16:18:53 +0000 (UTC)
In-Reply-To: <20120402205659.GA13725@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194784>

On Mon, 02 Apr 2012 15:57:00 -0500, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  - UI for storing the mapping between Subversion revision numbers and
>    git commit names in the git object db somewhere.  Currently we

I wrote a proof-of-concept importer which stored this mapping in notes. Worked
fairly well. Maybe I can dig up the code again.

tom
