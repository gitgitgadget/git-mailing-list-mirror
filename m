From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 20:30:11 -0500
Message-ID: <cs0GhwZZ9W-pJdXPmTo0di_hrUwMa14GE8dSJeIQtOwrvDdl4KxJ_g@cipher.nrlssc.navy.mil>
References: <S3I346LWUOykFBiCrFLgbfYptyYvHyj1Jcdo6EHe-2fWosEUh4Va3g@cipher.nrlssc.navy.mil> <hh0bQq8TcM0saDTuJo6qVdOMgn-14aysvhF_S70syB678Of7zQOsY9jLajG2WpeGXid8jtG4kVA@cipher.nrlssc.navy.mil> <7KKnonc5d5_rj_95MtHHlpKzcnmvDte62cL2vYgfQQkHguIG9qjT2A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 03:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9SxY-0007zE-4S
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 03:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab0JWBbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 21:31:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50322 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab0JWBbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 21:31:41 -0400
Received: by mail.nrlssc.navy.mil id o9N1UCbW006987; Fri, 22 Oct 2010 20:30:12 -0500
In-Reply-To: <7KKnonc5d5_rj_95MtHHlpKzcnmvDte62cL2vYgfQQkHguIG9qjT2A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Oct 2010 01:30:12.0280 (UTC) FILETIME=[D642A380:01CB7251]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159768>

On 10/22/2010 07:09 PM, Brandon Casey wrote:

> 	($fh, $ctx) =
> 	    $repo->command_output_pipe('blame', '-C', '-C', '-w', '--incremental',
> 		'--', $ls_tree->{'buf'});

I forgot to pass the revision to git-blame.

It should look like this:

 	($fh, $ctx) =
 	    $repo->command_output_pipe('blame', '-C', '-C', '-w', '--incremental',
 		$ARGV[0], '--', $ls_tree->{'buf'});

-Brandon
