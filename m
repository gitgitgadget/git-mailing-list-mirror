From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] unpack-trees: add function to update ce_flags
 based on sparse patterns
Date: Mon, 15 Nov 2010 12:30:40 -0600
Message-ID: <20101115183040.GD16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 19:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI3qP-0000mO-Dk
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 19:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112Ab0KOSbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 13:31:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42334 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab0KOSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 13:31:16 -0500
Received: by fxm6 with SMTP id 6so2005171fxm.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WhbpXvkF758hPqv9p/S+CGQzMnDe0YDhTqYsXv4FuDc=;
        b=CBsJlsroxwk1ZacEkGOe6/JuVG+crn3lCJX+5XOJ0c8KOliSh1ECDYQa57sleiCcZA
         NsmYs3/CBMZczm4Z9KxqGdpmIYtFUqbtNj+FCog6aTHSwWHLOw1T1Hd0y8O3rkz2Ho+a
         8EAe68YDtqrg5Wdi4NkG5QUoIzTUrluhYx/us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YxIAfKgXi6jRVSuOaNBOr7Eo9KeJAmp/LAK5zZcoMwDvWrKD1zKVjTbDBo4BKBi0YR
         2dHIhcyfTMBmU/mgawEgerjAoW61hvXmPHxOuSPR4Xwq6ynO/fKQJr6peeDRxZNWsw87
         zIO2nQsE/MSxo1+GXxg5ZpO9LMREzZkPbNs3s=
Received: by 10.223.97.10 with SMTP id j10mr151994fan.112.1289845875517;
        Mon, 15 Nov 2010 10:31:15 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j8sm982231fah.6.2010.11.15.10.31.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 10:31:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161498>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The function will reconstruct directory structure from index and feed
> excluded_from_list() with proper dtype.

Might be worth squashing with a patch introducing a caller; otherwise i=
t's
hard to get a sense of what these functions do.
