From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 10:32:00 -0400
Message-ID: <CADKp0px3v3K4vqNeNk7NdWZFdSCyqMa+i_Nv0wW80Tkf0C=RUQ@mail.gmail.com>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net> <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net> <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161526510.3303@virtualbox> <20160516133731.GA6903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 16:32:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2JZe-0003P6-CR
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 16:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcEPOcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 10:32:41 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37755 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcEPOck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 10:32:40 -0400
Received: by mail-ig0-f171.google.com with SMTP id s8so40470426ign.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HkRoGvjZg7p3DUfqs+DAkRFTiEY/kLSCGFJNjMamPcA=;
        b=UZjTpq4PUCf++D+OAXiTVomeDSokk7G7B2nxSqJf/qkLXR7dN/dfLT3uv421l6shKY
         JmJg9EvmVG0B8R4IUj52wZE/mKgW1fNs4SvPvSJoFn8NKGvWAZCrLCwzBliuD1KBzJch
         +DCE3mHGM6pn4+Mi1Qai/pN3OHrxeshemdw5WlU1NeVOykYeUBjBZAvcQTu5SCgO07VE
         beLO8qzgbu17QxDxHL9Mnmzh2y3P+S47lPOOSI4g5pJ5Z+/VujUFFPSmJjHps0hzBOwQ
         Uly4MHmdwTSJ3RPs02ewUBZD59JdlHUa9LvfRljRyIs5V5bGO8pmTBsQH2R+bamknICj
         kM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HkRoGvjZg7p3DUfqs+DAkRFTiEY/kLSCGFJNjMamPcA=;
        b=EwNd+byx8xDUcKbWOjhnRqvkrHD9GfeblVSk/oL1CyNow7nA8IwzBxx5czWPBgD8Rd
         5ozgYP+I3rf/k3KYXwKvvVm/jNhj7dEoxf5lR3XjtTkUU4GJBLZTR3n7roYbjVMBH5PC
         e4Joatz5pbpVf4zfaWVhkJTCyISJwXzIkJ/V0hY4G1vDfQgig0ocJmf8F8AEgkVuK2Yd
         IvHXwRHL1CZXnd7stmBhS61P0LXBMVG+swlkRCjUiLGi2fSZfzHJ58m3ty2o/Nb5nUF9
         9aHivWMHeC9TJolgFRUSQ17/5z9LK0Z5W1dI74Aq2Oc3LqJEtjoaDeBRFBRKWIvvqsL4
         fXHA==
X-Gm-Message-State: AOPr4FURokR3pfAHypp+dufMHqdfbL3K+6cnaDOqx7yS/wZLtkq3v5IP31wKnNANDX81YocsVdcJ/p80dy4ESA==
X-Received: by 10.50.58.166 with SMTP id s6mr11040627igq.13.1463409160001;
 Mon, 16 May 2016 07:32:40 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Mon, 16 May 2016 07:32:00 -0700 (PDT)
In-Reply-To: <20160516133731.GA6903@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294739>

Once I included the whole email in my reply, but otherwise I deleted it all.

Anyway, it is not a Powershell thing. I tested on another repo on
GitHub and it worked as expected. So I guess indeed the problem lies
with Microsoft's implementation.
