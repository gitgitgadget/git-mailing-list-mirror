From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 02/35] api-lockfile: expand the documentation
Date: Mon, 22 Sep 2014 16:13:39 +0200
Message-ID: <54202E93.4050707@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-3-git-send-email-mhagger@alum.mit.edu> <20140916202525.GB29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 16:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW4NA-00025k-5U
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 16:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbaIVONo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 10:13:44 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61649 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951AbaIVONn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2014 10:13:43 -0400
X-AuditID: 12074413-f79ed6d000002501-9d-54202e96fe7a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.58.09473.69E20245; Mon, 22 Sep 2014 10:13:42 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB23E6.dip0.t-ipconnect.de [93.219.35.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8MEDdbB023615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 22 Sep 2014 10:13:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916202525.GB29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqDtNTyHEYMkLTYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOOPNyDnvBQaWK/Yv+MzYw3pXqYuTkkBAwkTi19C4b
	hC0mceHeeiCbi0NI4DKjxLf9nxkhnPNMEn23W8CqeAW0JVat7mAFsVkEVCUOfXjGBGKzCehK
	LOppBrNFBQIkPnQ+YISoF5Q4OfMJC4gtIqAh8fzTN7ANzAIfGCUW35oNNkhYwEXibOMjqNUL
	GSWObH0FNolTwEDiycvjYJuZBdQl/sy7xAxhy0tsfzuHeQKjwCwkS2YhKZuFpGwBI/MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJBoEN7BuOuk3CFGAQ5GJR7eBU3yIUKs
	iWXFlbmHGCU5mJREeXM4FUKE+JLyUyozEosz4otKc1KLDzFKcDArifAGSQPleFMSK6tSi/Jh
	UtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvO26QI2CRanpqRVpmTklCGkmDk6Q4VxS
	IsWpeSmpRYmlJRnxoHiNLwZGLEiKB2jvEpB23uKCxFygKETrKUZdjnWd3/qZhFjy8vNSpcR5
	g0CKBECKMkrz4FbAUt8rRnGgj4V53UGqeIBpE27SK6AlTEBL7h+XB1lSkoiQkmpg9C+y33P7
	2Kkd34POWy2a/1ToePV/Lf/DuaXbzATEBTq+G1mLPeow05PxeDEz+9XCAH2Jty/E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257364>

On 09/16/2014 10:25 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> Document a couple more functions and the flags argument as used by
>> hold_lock_file_for_update() and hold_lock_file_for_append().
> 
> Thanks.
> 
> [...]
>> --- a/Documentation/technical/api-lockfile.txt
>> +++ b/Documentation/technical/api-lockfile.txt
>> @@ -28,9 +28,39 @@ hold_lock_file_for_update::
>>  	the final destination (e.g. `$GIT_DIR/index`) and a flag
>>  	`die_on_error`.  Attempt to create a lockfile for the
>>  	destination and return the file descriptor for writing
>> -	to the file.  If `die_on_error` flag is true, it dies if
>> -	a lock is already taken for the file; otherwise it
>> -	returns a negative integer to the caller on failure.
>> +	to the file.  The flags parameter is a combination of
>> ++
>> +--
> 
> Context: this document has structure
> 
> 	lockfile API
> 	============
> 
> 	Explanation of purpose (nice!).
> 
> 	The functions
> 	-------------
> 
> 	Quick descriptions of each of the four functions
> 	`hold_lock_file_for_update`, `commit_lock_file`,
> 	`rollback_lock_file`, `close_lock_file`.
> 
> 	Reminder about lifetime of the lock_file structure.
> 
> 	Description of cleanup convention (thou shalt either
> 	commit or roll back; if you forget to, the atexit
> 	handler will roll back for you).
> 
> 	Long warning about the harder use cases.  The above
> 	"thou shalt" was a lie --- you can also
> 	close_lock_file if you know what you're doing
> 	[jn: why is that function part of the public API?].
> 
> What's nice about the existing structure is that you can get
> a sense of how to use the API at a glance.  Would there be a
> way to add this extra information while preserving that property?
> 
> E.g.:
> 
> 	lockfile API
> 	============
> 
> 	Nice brief explanation of purpose ("is this the API
> 	I want to use?"), as before.
> 
> 	Calling sequence
> 	----------------
> 
> 	The caller:
> 
> 	* Allocates a variable `struct lock_file lock` in the bss
> 	section or heap.  Because the `lock_file` structure is used
> 	in an `atexit(3)` handler, its storage has to stay
> 	throughout the life of the program.  It cannot be an auto
> 	variable allocated on the stack.
> 
> 	* Attempts to create a lockfile by passing that variable and
> 	the filename of the final destination (e.g. `$GIT_DIR/index`)
> 	to `hold_lock_file_for_update` or `hold_lock_file_for_append`.
> 	+
> 	If the `die_on_error` flag is true, git dies if a lock is
> 	already taken for the file.
> 
> 	* Writes new content for the destination file by writing to
> 	`lock->fd`.
> 
> 	When finished writing, the caller can:
> 
> 	* Close the file descriptor and rename the lockfile to
> 	its final destination by calling `commit_lock_file`.
> 
> 	* Close the file descriptor and remove the lockfile by
> 	calling `rollback_lock_file`.
> 
> 	* Close the file descriptor without removing or renaming
> 	the lockfile by calling `close_lock_file`.
> 
> 	If you do not call one of `commit_lock_file`,
> 	`rollback_lock_file`, and `close_lock_file` and instead
> 	simply `exit(3)` from the program, an `atexit(3)` handler will
> 	close and remove the lockfile.
> 
> 	You should never call `close(2)` on `lock->fd` yourself~
> 	Otherwise the ...
> 
> 	Error handling
> 	--------------
> 
> 	Functions return 0 on success, -1 on failure.  errno is?
> 	isn't? meaningful on error.
> 
> 	... description of unable_to_lock_error and unable_to_lock_die
> 	here ...
> 
> 	Flags
> 	-----
> 
> 	LOCK_NODEREF::
> 
> 		Usually symbolic links in the destination path are
> 		resolved and the lockfile is created by adding ".lock"
> 		to the resolved path.  If `LOCK_NODEREF` is set, then
> 		the lockfile is created by adding ".lock" to the path
> 		argument itself.
> 
> What is the user-visible effect of that flag?  When would I want
> to pass that flag, and when wouldn't I?
> 
> 	LOCK_DIE_ON_ERROR::
> 
> 		If a lock is already taken for the file, `die()` with
> 		an error message.  If this option is not specified,
> 		trying to hold a lock file that is already taken will
> 		return -1 to the caller.
> 
> Sensible?
> Jonathan

OK, in the next reroll I will revise the documentation pretty
thoroughly. Please let me know what you think.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
