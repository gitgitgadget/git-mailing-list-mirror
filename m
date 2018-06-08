Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659DD1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 11:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeFHLGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 07:06:22 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54722 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeFHLGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 07:06:18 -0400
Received: by mail-wm0-f45.google.com with SMTP id o13-v6so2616533wmf.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZUwpQrU3SmUY+5mIIv9OEF1NQKsUXD0Wsjn87m8aBe4=;
        b=ph4vCW4IeKlZUNjLCGIwB1Gc2CPvJ+fwymWWVdOghtJ/eEXqnePc7NoEEqvTf9iInW
         qdMV2edqkOY7u79TcyD2HhWmL8A/6rq95XATIBegN33lvIynP6t/ww9qpE3V+xroDJzG
         J3+GDVEIbMewMshLnABglXVyhoohYXwpcLQcdbucVIX5X0LzoZIdyS+uHRnXikmmYm/1
         DOWIwzTGVAIDKZACuA6hZIQoe1PPeWd7MDjXqoz5RE7KsoqK2jf3UzkHDCixDx5QvJl2
         hz5MEMNts4kzstaXKWeJ/NFBPzHx8oWOIaITOMQk6badVbYVx5cwkc6MdQ66nqJt2PqV
         BecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZUwpQrU3SmUY+5mIIv9OEF1NQKsUXD0Wsjn87m8aBe4=;
        b=OxdU8vfKsz4TvqPMDBMmfQySlZNuolj1qYjm1FhUZLsO6cRXBm0TTnJto4HqDv/hYO
         2n+aV8X7c/mpGy4QwKxxd5o/ANKaugodbBaSLJGr/wf72unMt+omsdzwV1nJKfWN2/Xo
         /JAZBIdQMPsxVOJz8gepEHq+ZWuuhBLvBLOMN0T2x68TkiYWSGgdiNrvMRfbHPbH84+m
         FRazZ03iu9U9napj1c7NwmI4QKkCZdZ503iWPPPb9bbJFx17f5ieanYB9mVjhleVgkNu
         Lp5KCz/Ex4OGkr8JBdt2Ty5FF6H/TnFf29nJrUlUJm3gcHqEfXmKb0tTfO/LlBuk2AyM
         Y3OQ==
X-Gm-Message-State: APt69E12Re7PGAtJ7yz7NdxYFbPX+9fc2tp/+CE/raNsDRV/OBNgFPSc
        sRPEubz3ATeOCy9tM89Naec=
X-Google-Smtp-Source: ADUXVKIxgrJc997cr9mW3Iv4rJtqNN0qEGRPGd7fGejARqTIxoq0xlJeo6M5fMU7L16BUz9qyCEAEg==
X-Received: by 2002:aa7:d488:: with SMTP id b8-v6mr6519078edr.97.1528455977009;
        Fri, 08 Jun 2018 04:06:17 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id g37-v6sm5405008edg.47.2018.06.08.04.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 04:06:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry: design documenation
References: <20180607145313.25015-1-git@jeffhostetler.com> <20180607145313.25015-2-git@jeffhostetler.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180607145313.25015-2-git@jeffhostetler.com>
Date:   Fri, 08 Jun 2018 13:06:15 +0200
Message-ID: <87zi05y1ug.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 07 2018, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create design documentation to describe the telemetry feature.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/technical/telemetry.txt | 475 ++++++++++++++++++++++++++++++++++
>  1 file changed, 475 insertions(+)
>  create mode 100644 Documentation/technical/telemetry.txt
>
> diff --git a/Documentation/technical/telemetry.txt b/Documentation/technical/telemetry.txt
> new file mode 100644
> index 0000000..0a708ad
> --- /dev/null
> +++ b/Documentation/technical/telemetry.txt
> @@ -0,0 +1,475 @@
> +Telemetry Design Notes
> +======================
> +
> +The telemetry feature allows Git to generate structured telemetry data
> +for executed commands.  Data includes command line arguments, execution
> +times, error codes and messages, and information about child processes.
> +
> +Structued data is produced in a JSON-like format.  (See the UTF-8 related

s/Structued/Structured/

> +"limitations" described in json-writer.h)
> +
> +Telemetry data can be written to a local file or sent to a dynamically
> +loaded shared library via a plugin API.
> +
> +The telemetry feature is similar to the existing trace API (defined in
> +Documentation/technical/api-trace.txt).  Telemetry events are generated
> +thoughout the life of a Git command just like trace messages.  But where

s/thoughout/throughout/

> +as trace messages are essentially developer debug messages, telemetry
> +events are intended for logging and automated analysis.
> +
> +The goal of the telemetry feature is to be able to gather usage data across
> +a group of production users to identify real-world performance problems in
> +production.  Additionally, it might help identify common user errors and
> +guide future user training.
> +
> +By default, telemetry is disabled.  Telemetry is controlled using config
> +settings (see "telemetry.*" in Documentation/config.txt).
> +
> +
> +Telemetry Events
> +================
> +
> +Telemetry data is generated as a series of events.  Each event is written
> +as a self-describing JSON object.
> +
> +Events: cmd_start and cmd_exit
> +------------------------------
> +
> +The `cmd_start` event is emitted the very beginning of the git.exe process
> +in cmd_main() and `cmd_exit` event is emitted at the end of the process in
> +the atexit cleanup routine.
> +
> +For example, running "git version" produces:
> +
> +{
> +  "event_name": "cmd_start",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "version"
> +  ],
> +  "clock": 1525978509976086000,
> +  "pid": 25460,
> +  "git_version": "2.17.0.windows.1",
> +  "telemetry_version": "1",
> +  "session_id": "1525978509976086000-25460"
> +}
> +{
> +  "event_name": "cmd_exit",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "version"
> +  ],
> +  "clock": 1525978509980903391,
> +  "pid": 25460,
> +  "git_version": "2.17.0.windows.1",
> +  "telemetry_version": "1",
> +  "session_id": "1525978509976086000-25460",
> +  "is_interactive": false,
> +  "exit_code": 0,
> +  "elapsed_time_core": 0.004814,
> +  "elapsed_time_total": 0.004817,
> +  "builtin": {
> +    "name": "version"
> +  }
> +}
> +
> +Fields common to all events:
> + * `event_name` is the name of the event.
> + * `argv` is the array of command line arguments.
> + * `clock` is the time of the event in nanoseconds since the epoch.
> + * `pid` is the process id.
> + * `git_version` is the git version string.
> + * `telemetry_version` is the version of the telemetry format.
> + * `session_id` is described in a later section.

I wonder if we should add the path to git to these if RUNTIME_PREFIX is
defined. Would be useful to log experiments with different git versions,
and as noted by the RUNTIME_PREFIX feature this information is not
guaranteed to be something you can extract from argv.

> +Additional fields in cmd_exit:
> + * `is_interactive` is true if git.exe spawned an interactive child process,
> +      such as a pager, editor, prompt, or gui tool.
> + * `exit_code` is the value passed to exit() from main().
> + * `error_message` (not shown) is the array of error messages.
> + * `elapsed-core-time` measures the time in seconds until exit() was called.
> + * `elapsed-total-time` measures the time until the atexit() routine starts
> +      (which will include time spend in other atexit() routines cleaning up
> +      child processes and etc.).
> + * `alias` (not shown) the updated argv after alias expansion.
> + * `builtin.name` is the canonical command name (from the cmd_struct[]
> +      table) of a builtin command.
> + * `builtin.mode` (not shown) is shown for some commands that have different
> +      major modes and performance times.  For example, checkout can switch
> +      branches or repair a single file.
> + * `child_summary` (not shown) is described in a later section.
> + * `timers` (not shown) is described in a later section.
> + * `aux` (not shown) is described in a later section.
> +
> +
> +Events: child_start and child_exit
> +----------------------------------
> +
> +The child-start event is emitted just before a child process is started.
> +It includes a unique child-id and the child's command line arguments.
> +
> +The child-exit event is emitted after a child process exits and has
> +been reaped.  This event extends the start event with the child's exit
> +status and elapsed time.
> +
> +For example, during a "git fetch origin", git.exe runs gc in the background
> +and these events are emitted by the fetch process before and after the
> +child gc process:
> +
> +{
> +  "event_name": "child_start",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "fetch",
> +    "origin"
> +  ],
> +  "clock": 1525979478738132887,
> +  "pid": 18332,
> +  "git_version": "2.17.0.windows.1",
> +  "telemetry_version": "1",
> +  "session_id": "1525979470792747000-18332",
> +  "child_detail": {
> +    "number": 3,
> +    "class": "gc",
> +    "argv": [
> +      "gc",
> +      "--auto"
> +    ]
> +  }
> +}
> +{
> +  "event_name": "child_exit",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "fetch",
> +    "origin"
> +  ],
> +  "clock": 1525979479024707085,
> +  "pid": 18332,
> +  "git_version": "2.17.0.windows.1",
> +  "telemetry_version": "1",
> +  "session_id": "1525979470792747000-18332",
> +  "child_detail": {
> +    "number": 3,
> +    "class": "gc",
> +    "argv": [
> +      "gc",
> +      "--auto"
> +    ],
> +    "pid": 19608,
> +    "exit_code": 0,
> +    "elapsed_time": 0.286574
> +  }
> +}
> +
> +The common fields (`event_name` through `session_id`) are the same as
> +in the `cmd_start` and `cmd_exit` events and refer to the parent process.
> +
> +The `child_detail` structure describes the child process:
> + * `number` is a simple counter incremented for each child event.
> + * `class` is a rough characterization of the type of child process.  Child
> +      class is described in a later section.
> + * `argv` is the child's command line.
> + * `pid` is the child's process id.
> + * `exit_code` is the exit code of the child process.
> + * `elapsed_time` measures the time in seconds observed by the parent process
> +      between the child_start and child_exit events.  This will be greater
> +      than the elapsed time that the child internally observes because of
> +      process startup and shutdown overhead.  For synchronous child processes,
> +      this is the time that the parent spent waiting for the child.
> +
> +
> +Event: perf
> +-----------
> +
> +Perf events are a debugging aid to report on suspected hot spots in the
> +code and collect data from production users.  This is intended to be a
> +generic message with context-specific data.  New messages may be added
> +in the future as the need arises to help with debugging.
> +
> +Perf events are organized by category, much like the various GIT_TRACE_*
> +environment variables.  The "telemetry.perf" config setting can be set to
> +true or to a string of the perf categories that should be enabled.
> +
> +Currently, the categories "index" and "status" are defined.  Others may
> +be added later.
> +
> +For example, could be used to instrument read_index_from():
> +
> +{
> +  "event_name": "perf",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "fetch",
> +    "origin"
> +  ],
> +  "clock": 1525979478735438090,
> +  "pid": 18332,
> +  "git_version": "2.17.0.windows.1",
> +  "telemetry_version": "1",
> +  "session_id": "1525979470792747000-18332",
> +  "category": "index",
> +  "label": "read_index_from",
> +  "elapsed_time": 0.001536,
> +  "data": {
> +    "path": ".git/index",
> +    "cache_nr": 3311
> +  }
> +}
> +
> +The common fields (`event_name` through `session_id`) are the same as
> +in the `cmd_start` and `cmd_exit` events.
> +
> +All `perf` events also have:
> + * `category` is descriptive category and used like different GIT_TRACE_*
> +      variables.
> + * `label` is the name of a function or region of interest.
> + * `elapsed_time` measures the time in seconds spent in the function or
> +      region.
> + * `data` is an optional structure of context-specific (debug) data.
> +
> +
> +More Details for Event Fields
> +=============================
> +
> +Field: session_id
> +-----------------
> +
> +A session_id (SID) is a cheap, unique-enough string to associate all of
> +the events generated by a single process.  They incorporate the inherited
> +SID from their parent process.
> +
> +SIDs should be considerd opaque data, but are constructed as:

s/considerd/considered/

> +
> +    [<parent_sid>]/<start_time>-<pid>
> +
> +This scheme is used rather than a simple PID or {PPID, PID} because PIDs
> +are recycled by the OS (after sufficient time).  Also, if telemetry data
> +is aggregated from multiple systems, PIDs are not sufficient.
> +
> +This also has the advantage of allowing telemetry analysis to associate
> +Git child processes with their Git parent process even if there are
> +intermediate shell processes.
> +
> +Note: we could use UUIDs or GUIDs for this, but that seemed overkill at
> +this point.  It also required platform-specific code to generate which
> +muddied up the code.

Fully agreed, UUID would be overkill, and it's a very useful property to
have the timestamp in there, since this is very likely to end up in a
storage system where this is a primary key, and being able to just look
at those and see from what time they without also looking at "clock" is
useful.

Just as a bit of bikeshedding, I wonder if this would be better with the
<start_time> always at the start,
i.e. <start_time>-<parent_sid>-<pid>. Without a parent it would be
TIME--PID but with a parent TIME-PARENT_SID-PID.

The reason I'm suggesting that that is that if I e.g. make a MySQL table
to insert these records and use the SID as a primary key, the inserts
are much more efficient if they're in sorted order and all sort after
existing data. That's not *guaranteed* with my proposed amendmend, but
as a practical matter would be the case most of the time.

This is a property shared by a lot of DB storage formats, and it would
be useful to cater to it.

That's mostly true of <parent_sid>-<start_time>-<pid> too, but there's
going to be cases (e.g. gc) where we're starting subprocesses for a long
time, so by inserting new entries starting with <parent_sid> at the
beginning we're having to write behind in such a system.

But maybe you were aiming for the property of having all events invoked
by a given git (and the children) really closely packed together in such
a system.

I don't feel strongly about it, just something to consider.

> +Field: child_details.class
> +--------------------------
> +
> +enum telemetry_class contains a set of classification values.  These attempt
> +to roughly classify a child process from the point of view of the parent
> +process.
> + * unclass: unclassified
> + * unclass-async: unclassified asynchronous child (see sub-process.c)
> + * alias: an alias expansion using a child process
> + * hook: a hook process that may do anything (including prompting, scanning,
> +   and network operations) and wildly affect command run times.
> + * pager: a pager (indicating an interactive command)
> + * editor: an editor (indicating an interactive command)
> + * prompt: a prompt or credential or askpass process (also interactive)
> + * network: a command that might do network operations
> + * convert: an attribute filter process such as LFS or CRLF
> + * tool: a tool, such as difftool or mergetool, that may be interactive
> + * gc: an auto gc process
> +
> +struct child_process has been extended to have a telemetry_class field.  Some
> +callers of start_command() and/or run_command() have been updated to suggest
> +a classification when appropriate.  For example, child processes created by
> +launch_editor() are marked with TELEMETRY_CLASS__EDITOR.
> +
> +The primary intent is to identify which child processes are likely to block
> +on the user or network.  For example, "git commit" and "git commit -m <msg>"
> +will have different performance characteristics because the former has to
> +launch an editor and wait for the user to compose a message.  The former will
> +have a child event which child_detail.class=editor and its exit event will
> +have child_summary.editor.count=1 and child_summary.editor.elapsed_time=<t>.
> +Analysis tools can choose to report average commit time for non-interactive
> +commands or subtract the editor elapsed time from the commit elapsed time.
> +
> +For example, fetch runs rev-list, ssh, index-pack, and maybe (auto) gc.  The
> +ssh child is marked as TELEMETRY_CLASS__NETWORK and the gc child is marked
> +as TELEMETRY_CLASS__GC (since it is optional and possibly time consuming).
> +The others are left unclassified (TELEMETRY_CLASS__UNCLASS) since we don't
> +expect blocking operations.

This whole thing is very useful, and worth the small effort on our end
to classify commands as "might use network" etc.

> +Field: child_summary
> +--------------------
> +
> +The `child_summary` structure within the `cmd_exit` event summarizes the
> +child processes created by the parent process.
> +
> +For example, "git fetch origin" spawns 4 child processes:
> +
> +{
> +  "event_name": "cmd_exit",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "fetch",
> +    "origin"
> +  ],
> +  ...
> +  "child_summary": {
> +    "unclass": {
> +      "count": 2,
> +      "elapsed_time": 0.496387
> +    },
> +    "network": {
> +      "count": 1,
> +      "elapsed_time": 7.712466
> +    },
> +    "gc": {
> +      "count": 1,
> +      "elapsed_time": 0.286574
> +    }
> +  },

If we're going to have "clock" be the nanosecond epoch, let's not have
FLOAT seconds here, but instead just make "elapsed_time" be the elapsed
time in nanoseconds.

That'll both simplify dealing with this manually, and e.g. the schema of
any DB that this gets inserted into.

> +  "exit_code": 0,
> +  "elapsed_time_core": 8.232965,
> +  "elapsed_time_total": 8.232968,

Ditto the parent's elapsed time....

> +  "builtin": {
> +    "name": "fetch"
> +  }
> +}
> +
> +Within each `child_summary[<class>]` is a count of the number of child
> +processes and the cummulative elapsed time.

s/cummulative/cumulative/

> +Analysis tools interested in a net-elapsed-time of the parent process may
> +want to subtract the elapsed time of the child processes.  This approach is
> +mostly valid, since most child processes are run synchronously.  However,
> +some processes are run asynchronously, such as the pager and processes in
> +the unclass-async pool, so care should be taken.

... Exactly for this reason, now anyone wanting to do that math is
having to deal with the minefield that is IEEE Floating-Point
Arithmetic.

> +Field: timers
> +-------------
> +
> +A "telemetry timer" is a stopwatch-like timer with a counter.  It can be
> +used to time a specific region of code, such as an expensive computation
> +within the body of a larger loop.  It defines a generic way to collect
> +perf data without causing an telemetry perf event to be fired on each
> +iteration.  Instead, a timer is registered with the telemetry layer and
> +the data will be included in a "timers" sub-section in the `cmd_exit` event.
> +
> +For example, a timer was added to do_read_index() and do_write_index()
> +to measure the time spent reading and writing the index.
> +
> +{
> +  "event_name": "cmd_exit",
> +  "argv": [
> +    "C:\\work\\gfw\\git.exe",
> +    "status"
> +  ],
> +  ...
> +  "timers": {
> +    "do_read_index": {
> +      "count": 1,
> +      "total": 0.000740,
> +      "min": 0.000740,
> +      "max": 0.000740,
> +      "avg": 0.000740
> +    },
> +    "do_write_index": {
> +      "count": 1,
> +      "total": 0.004724,
> +      "min": 0.004724,
> +      "max": 0.004724,
> +      "avg": 0.004724
> +    }
> +  },
> +  "exit_code": 0,
> +  "elapsed_time_core": 0.049865,
> +  "elapsed_time_total": 0.049867,
> +  "builtin": {
> +    "name": "status"
> +  }
> +}
> +
> +The `timers` structure contains a named member for each defined timer.
> +Within each individual timer, we have:
> + * `count` is the number of times it was started/stopped.
> + * `total` is the total time the timer was running.
> + * `min` is the shortest interval.
> + * `max` is the longest interval.
> + * `avg` is the average interval.

I wonder if we should add "median" here, although that would (unless
I've missed some clever trick) require keeping all the times around,
sorting them and then picking the 50th percentile, whereas we can
compute a running min/avg/max. So maybe it should be optional (this can
always be added later).

Once we have that we can easily add 10/25/50/75/90/95/99th percentiles
as well.

> +Field: aux
> +---------------
> +
> +The `aux` structure within the `cmd_exit` event contains additional
> +information about the process.  This is intended as a generic container for
> +various fields, such as important config settings or repo data shape that
> +may affect performance or help identify the repository for aggregation
> +purposes.
> +
> +{
> +  "event_name": "cmd_exit",
> +  ...
> +  "aux": {
> +    "remote_origin_url": "git@github.com:git/git.git",
> +    "index_count": 3311,
> +    "sparse_checkout_count": 3
> +  },
> +  ...
> +}
> +
> +Other fields (and even sub-structures) can be added to this container
> +as needed.
> +
> +
> +Telemetry Destination
> +=====================
> +
> +Telemetry events are sent to a "destination".  This can be a file or a
> +plugin.  Telemetry is disabled if a destination is not set.
> +
> +telemetry.path

There is the telemetry.plugin escape hatch noted below I can change it,
but I don't like the design of this, because:

1) On POSIX systems (I don't know about Windows) if you O_APPPEND to
such a file you're guaranteed at most PIPE_MAX bytes written to the file
before there's no guarantee that your write is atomic, i.e. you will get
interleaved JSON if we ever write something bigger than that.

From the spec above it seems like this will be unlikely in practice for
most simple invocations, but with "aux" payloads and a sufficient amount
of child processes & timers I can see us easily going over PIPE_MAX,
which is commonly 4096 (e.g. the linux default).

2) It makes it hard to process these events piecemeal and in parallel,
i.e. imagine having all the dev machines NFS mount some logging FS where
they all write to this file, now I need to periodically move that file,
or ensure the config is set so we write to a daily/hourly file etc.

A tiny modification on this would address #1 and #2. We would make
telemetry.path the path to a directory where metrics are written, and
then write e.g. <THAT_DIRECTORY>/<first 2 chars of sid>/<remaining chars
of sid>, similar to how we write loose objects.

Then a bunch of processes could write to those files in parallel without
fear of clobbering anything, and anything consuming them could easily do
so with a standard readdir() + stat() + rename(F -> F.doing) &&
unlink(F.doing) pattern.

But reading between the lines you're not planning to use this yourself
at all, and we can always add a telemetry.directory later with this
behavior, leaving telemetry.path for a "simple" backend (while
prominently advertising that PIPE_MAX caveat).

> +If the config setting "telemetry.path" contains a pathname, telemetry
> +events will be appended to that file using the builtin destination
> +handler.  (File rotation is beyond the scope of this design.)
> +
> +Events are written as a series of JSON records.  When "telemetry.pretty"
> +is false, each event record will be written on one line.
> +
> +(All of the examples in this document were prepared with "telemetry.pretty"
> +set to true.)
> +
> +telemetry.plugin
> +----------------
> +
> +If the config setting "telemetry.plugin" contains the pathname to a shared
> +library, the library will be dynamically loaded during start up and events
> +will be sent to it using the plugin API.
> +
> +This plugin model allows an organization to define a custom or private
> +telemetry solution while using a stock version of Git.
> +
> +For example, on Windows, it allows telemetry events to go directly to the
> +kernel via the plugin using the high performance Event Tracing for Windows
> +(ETW) facility.
> +
> +The contrib/telemetry-plugin-examples directory contains two example
> +plugins:
> + * A trivial log to stderr
> + * A trivial ETW writer

Maybe we should also have a telemetry.hook for flexibility on systems
where invoking processes isn't expensive :)

This is a bit of scope creep on what you're trying to accomplish, but I
wonder if we could keep the requirements for some sort of general *.so
hook facility in mind with this.

Our hooks now do relatively simple things like take a stream on STDIN,
get ENV vars, and inspect ARGV. Could we generalize this to using some
callback mechanism that provides those, so this could also be used for
other existing hooks?

> +GDPR and Privacy
> +================
> +
> +The telemetry feature can log possibly sensitive user information (such as
> +command line arguments, which may contain URLs, user names, and file names).
> +
> +The base telemetry feature can write telemetry data to a file on the system.
> +
> +The plugin facility can be used to publish the telemetry data to more general
> +destinations (such as ETW or the network).
> +
> +In both cases, it is up to the user or system administrator to decide what
> +is appropriate and sanitize the data accordingly before broadcasting it.
