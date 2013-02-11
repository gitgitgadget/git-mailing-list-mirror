From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:21:54 -0800
Message-ID: <20130211072154.GN15329@elie.Belkin>
References: <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nid-0002ce-Me
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab3BKHWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:22:04 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:56417 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3BKHWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:22:03 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2595091dak.19
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lADLCKKZQ74GPTwOShk5/ZKjpvzQuc2tJABgfSiL3xw=;
        b=uLXwbpNleXo8dc8J53FZkTh+cEXyKmf1ll/oZ3SzhQpOrAhzfgBkG6m/XgXDZvye2R
         HeG0omsIW83ueJxxTyq5z+h7qXu0SJMb8TrZaM3wzYNu7LFTIrPypnG309hG1Pn2JZFI
         Q1oocKWUMq8kIqi6bFSf4thzDEC7oeKh65WSEYyNp4NKJhHSk9EBtF6p8NVOAJdnOzT1
         rENrssF/krHcyZ+WEEtHdHCK93FwHi7Zry983+LAOtLtX8sjJ5odaGJxAdzmpLYVOsDP
         Wi/7M2lpioThxSf+U2XNsbsv9tPl+TzcN2W839ED5N/rvf9l4vtl9AhmiOfXpbj4JWLL
         QPhQ==
X-Received: by 10.68.23.194 with SMTP id o2mr16358051pbf.41.1360567322133;
        Sun, 10 Feb 2013 23:22:02 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id z10sm66055212pay.7.2013.02.10.23.21.59
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 23:22:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216014>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Isn't that a criticism of the git-shell-commands facility in general?
>> If it is common to have a lot of users with distinct home directories
>> but all with git-shell as their login shell, then the
>> git-shell-commands should not go in their home directory to begin
>> with, no?
>
> You can give one set of commands to some users while restricting
> others, no?

Yes, I assume one goal of the current design was to let you set up
multiple configurations by making multiple home directories.
