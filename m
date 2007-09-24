From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 08:26:30 +0200
Message-ID: <85k5qgk295.fsf@lola.goethe.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 08:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZhOw-0006Yz-9c
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 08:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXIXG0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 02:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXIXG0c
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 02:26:32 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:52484 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241AbXIXG0c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2007 02:26:32 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id CDDE7302C7D;
	Mon, 24 Sep 2007 08:26:30 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id C2F5B5BD6A;
	Mon, 24 Sep 2007 08:26:30 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-020-020.pools.arcor-ip.net [84.61.20.20])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id B20A136E863;
	Mon, 24 Sep 2007 08:26:30 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4E6701C1F3DC; Mon, 24 Sep 2007 08:26:30 +0200 (CEST)
In-Reply-To: <20070924060521.GB10975@glandium.org> (Mike Hommey's message of "Mon\, 24 Sep 2007 08\:05\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59022>

Mike Hommey <mh@glandium.org> writes:

> On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
>> -while case $# in 0) break ;; esac
>> +while test $# != 0
>
> Wouldn't -ne be better ?

Why?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
