From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Mon, 1 Sep 2008 20:23:52 -0400
Message-ID: <32541b130809011723l1cd8abfid9228363f952875@mail.gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
	 <20080830183413.GG7185@schiele.dyndns.org>
	 <20080830183949.GA16415@coredump.intra.peff.net>
	 <200808302237.17017.jnareb@gmail.com>
	 <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
	 <20080901214254.GA8058@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Robert Schiele" <rschiele@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 02:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaJhe-0008Nu-DF
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 02:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYIBAXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 20:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYIBAXz
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 20:23:55 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:47957 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbYIBAXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 20:23:54 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1220372yxm.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=45KuJN1jul9VS5acHaeU2ZOaWPBrdKcaNgBxAmFesnM=;
        b=Av+zT+1qDTNvzQI9WnFWk0GOdxTgvqfJm6J8gf1OUWGUWhfXR1ssA4hy6dTXCqpGgk
         AyrrWvZaM+SIz+NpJqTfx3MrjZ/Zsr2RV58i/mwtUpRYJbohaneFDxDnvU67EDss30Ex
         dijG35/yBK6J9LFMChFbjiOCQOAX+gNUZHSV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q4tzyrxAMh2RnTNavRIvaTfgbZ3OlLWzjUKN0nBIPWTk7etEJduMG3I2IOLydjc18L
         dDA+4fWGRB7b7kVUhDCh02cCMBBLUfXUqpFmI/vHBJmGdj9tJUrMM3Dl1pduUnWlQqc+
         qPKOFP22knGNrjIP26eHdNfV6KaDJftIRxeIM=
Received: by 10.151.106.4 with SMTP id i4mr9519862ybm.119.1220315032976;
        Mon, 01 Sep 2008 17:23:52 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 1 Sep 2008 17:23:52 -0700 (PDT)
In-Reply-To: <20080901214254.GA8058@blimp.localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94632>

On Mon, Sep 1, 2008 at 5:42 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Avery Pennarun, Sun, Aug 31, 2008 07:35:31 +0200:
>> On Sat, Aug 30, 2008 at 4:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> > Or you can use "open $fd, '-|'" to fork, an "manually" exec/system.
>>
>> Shell quoting is a disaster (including security holes, where relevant)
>> waiting to happen.  The above is the only sane way to do it, and it
>> isn't very hard to implement. ...
>
> except on Windows, where it is impossible to implement.

True.  Although every program parses its own options on Windows, so
proper, safe quoting is *also* impossible to implement.

Avery
