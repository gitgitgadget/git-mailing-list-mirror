X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Fix regression tests on Cygwin
Date: Wed, 25 Oct 2006 08:39:36 +0200
Message-ID: <8c5c35580610242339r7c2501dh7165dea49965632b@mail.gmail.com>
References: <11616320733093-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.63.0610241653020.2106@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vwt6pdn46.fsf@assigned-by-dhcp.cox.net>
	 <7vods1dmnu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 06:39:55 +0000 (UTC)
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mCkwVpqdgvrUj2ykdW6gTAEgv4q4q1AcUXpa2Ms7HxpkA6Tr2s0c0HbREeZu7Kfv2V2w+LfvB6N4cPVtbgLC2aRp/l22Bn5hdxsyOKea/iJ/8sIosRxxppXFsR6rAfZCZZjkrEVyw/tZSgiM6sKe0v1VdeufeySMpqJU4r3Mr7E=
In-Reply-To: <7vods1dmnu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30035>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GccQQ-0000Tg-RX for gcvg-git@gmane.org; Wed, 25 Oct
 2006 08:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423059AbWJYGjj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 02:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423062AbWJYGjj
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 02:39:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40589 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1423059AbWJYGji
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 02:39:38 -0400
Received: by nf-out-0910.google.com with SMTP id c2so490488nfe for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 23:39:37 -0700 (PDT)
Received: by 10.82.142.9 with SMTP id p9mr29458bud; Tue, 24 Oct 2006 23:39:36
 -0700 (PDT)
Received: by 10.82.171.10 with HTTP; Tue, 24 Oct 2006 23:39:36 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 10/25/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> On Mon, 23 Oct 2006, Lars Hjemli wrote:
> >>
> >>> On Cygwin, "make test" failes due to missing ".exe" a couple of places.
> >>
> >> Last time I made "test" on cygwin, it did not complain.
> >
> > Same here (W2k, fairly up-to-date git, installed on local NTFS
> > disk).

Well, then it's probably my cygwin-environment that is broken (make
test used to work for me too...)

Sorry for the noise

--
